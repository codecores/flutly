import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/core/flutly_app_bar/flutly_ab_section.dart';
import 'package:flutly/core/flutly_app_bar/flutly_app_bar.dart';
import 'package:flutly/core/flutly_tab_bar/flutly_multi_tab_controller.dart';
import 'package:flutly/core/flutly_tab_bar/flutly_tab_controller.dart';
import 'package:flutly/core/flutly_tab_bar/flutly_tab_view_controller.dart';
import 'package:flutly/core/flutly_bottom_bar/flutly_bb_section.dart';
import 'package:flutly/core/flutly_bottom_bar/flutly_bottom_bar.dart';
import 'package:flutly/core/flutly_config.dart';
import 'package:flutly/core/flutly_page.dart';
import 'package:flutly/core/flutly_theme.dart';
import 'package:flutly/core/flutly_transaction.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/models/flutly_bottom_bar_item.dart';
import 'package:flutter/material.dart'; /*  */
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class FlutlyApp extends StatefulWidget {
  final List<FlutlyPage> pages;
  final FlutlyBottomBar? bottomBar;
  final FlutlyAppBar? appBar;
  final List<FlutlyTabViewController>? tabBars;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final RouterConfig<Object>? routerConfig;
  final BackButtonDispatcher? backButtonDispatcher;
  final String title;
  final String Function(BuildContext)? onGenerateTitle;
  final Color? color;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeData? highContrastTheme, highContrastDarkTheme;
  final ThemeMode? themeMode;
  final Widget Function(BuildContext, Widget?)? builder;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Locale? Function(List<Locale>?, Iterable<Locale>)?
      localeListResolutionCallback;
  final Locale? Function(Locale?, Iterable<Locale>)? localeResolutionCallback;
  final Iterable<Locale>? supportedLocales;
  final bool debugShowMaterialGrid;
  final bool showPerformanceOverlay,
      checkerboardRasterCacheImages,
      checkerboardOffscreenLayers,
      showSemanticsDebugger,
      debugShowCheckedModeBanner,
      useInheritedMediaQuery;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final String? restorationScopeId;
  final ScrollBehavior? scrollBehavior;
  const FlutlyApp({
    Key? key,
    required this.pages,
    this.bottomBar,
    this.appBar,
    this.tabBars,
    this.scaffoldMessengerKey,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.routerConfig,
    this.backButtonDispatcher,
    this.title = '',
    this.onGenerateTitle,
    this.builder,
    this.color,
    this.theme,
    this.darkTheme,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.themeMode = ThemeMode.system,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.scrollBehavior,
    @Deprecated('Remove this parameter as it is now ignored. '
        'MaterialApp never introduces its own MediaQuery; the View widget takes care of that. '
        'This feature was deprecated after v3.7.0-29.0.pre.')
    this.useInheritedMediaQuery = false,
  }) : super(key: key);

  @override
  _FlutlyAppState createState() => _FlutlyAppState();
}

class _FlutlyAppState extends State<FlutlyApp> {
  late GoRouter router;

  @override
  void initState() {
    List<RouteBase> routes = List.empty(growable: true);
    routes.addAll(registerRoutes());
    routes.addAll(registerNavigationRoutes());

    router = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: routes,
    );

    if (widget.tabBars != null) {
      Flutly.getFlutlyConfig().tabBars.clear();
      widget.tabBars!.forEach(
        (element) {
          Flutly.getFlutlyConfig().tabBars.add(element);
        },
      );
    }

    super.initState();
  }

  List<RouteBase> registerRoutes() {
    List<RouteBase> routes = List.empty(growable: true);
    for (var route in widget.pages) {
      routes.add(
        GoRoute(
          name: route.name,
          path: route.path,
          onExit: route.onExit,
          pageBuilder: (BuildContext context, GoRouterState state) {
            Get.find<FlutlyConfig>().setCurrentRoute(
              state.fullPath!,
              widget.bottomBar!
                      .getItemWithPath(state.fullPath!)!
                      .appBarHeight ??
                  0,
            );
            return FlutlyTransaction.getDefaultTransaction(
                state.pageKey, route.page);
          },
        ),
      );
    }

    return routes;
  }

  List<RouteBase> registerNavigationRoutes() {
    List<RouteBase> routes = List.empty(growable: true);

    if (widget.bottomBar != null) {
      if (widget.bottomBar!.items.isNotEmpty) {
        List<RouteBase> navigationRoutes = List.empty(growable: true);
        for (var route in widget.bottomBar!.items) {
          List<RouteBase> childNavigationRoutes = List.empty(growable: true);
          if (route.children != null) {
            for (var route in route.children!) {
              childNavigationRoutes.add(
                GoRoute(
                  name: route.page.name,
                  path: route.page.path,
                  onExit: route.page.onExit,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    Get.find<FlutlyConfig>().setCurrentRoute(
                      state.fullPath!,
                      widget.bottomBar!
                              .getItemWithPath(state.fullPath!)!
                              .appBarHeight ??
                          0,
                    );
                    return FlutlyTransaction.getTransaction(route.getTransactionType(),
                    state.pageKey, route.page.page);
                  },
                ),
              );
            }
          }
          navigationRoutes.add(
            GoRoute(
              name: route.page.name,
              path: route.page.path,
              onExit: route.page.onExit,
              pageBuilder: (BuildContext context, GoRouterState state) {
                Get.find<FlutlyConfig>().setCurrentRoute(
                  state.fullPath!,
                  widget.bottomBar!
                          .getItemWithPath(state.fullPath!)!
                          .appBarHeight ??
                      0,
                );
                return FlutlyTransaction.getTransaction(route.getTransactionType(),
                    state.pageKey, route.page.page);
              },
              routes: childNavigationRoutes,
            ),
          );
        }

        routes.add(
          ShellRoute(
            routes: navigationRoutes,
            builder: (context, state, child) {
              Get.find<FlutlyConfig>().context = context;
              return FlutlyMultiTabController(
                controllers: Flutly.getFlutlyConfig().tabBars,
                child: Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: GetBuilder<FlutlyConfig>(
                    builder: (controller) {
                      FlutlyBottomBarItem? item = widget.bottomBar!
                          .getItemWithPath(controller.getCurrentRoute());

                      bool appBarAnimated = false;
                      double appBarHeight = 80;

                      if (item != null) {
                        appBarHeight = item.appBarHeight ?? 80;
                        appBarAnimated = item.isAnimatedAppBar();
                      }

                      appBarHeight += MediaQuery.of(context).padding.top;

                      return Stack(
                        children: [
                          Column(
                            children: [
                                  AnimatedContainer(
                                      width: double.infinity,
                                      height: appBarHeight,
                                      duration:
                                           Duration(milliseconds: appBarAnimated ? 300 : 0),
                                      curve: Curves.easeInOutCubic,
                                    ),
                              Flexible(child: child),
                            ],
                          ),
                          FlutlyAbSection(
                            appBar: widget.appBar,
                            appBarHeight: appBarHeight,
                            item: item,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child:
                                FlutlyBbSection(bottomBar: widget.bottomBar!),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      }
    }

    return routes;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(Flutly.screenInitialWidth, Flutly.screenInitialHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => child ?? const SizedBox(),
      child: GetBuilder<FlutlyTheme>(
        builder: (controller) {
          return MaterialApp.router(
            title: widget.title,
            theme: widget.theme ?? controller.getThemeData(),
            scaffoldMessengerKey: widget.scaffoldMessengerKey,
            backButtonDispatcher: widget.backButtonDispatcher,
            routerConfig: router,
            localizationsDelegates:
                widget.localizationsDelegates ?? context.localizationDelegates,
            supportedLocales:
                widget.supportedLocales ?? context.supportedLocales,
            locale: widget.locale ?? context.locale,
            //others
            onGenerateTitle: widget.onGenerateTitle,
            color: widget.color,
            darkTheme: widget.darkTheme,
            highContrastTheme: widget.highContrastTheme,
            highContrastDarkTheme: widget.highContrastDarkTheme,
            themeMode: widget.themeMode,
            localeListResolutionCallback: widget.localeListResolutionCallback,
            localeResolutionCallback: widget.localeResolutionCallback,
            debugShowMaterialGrid: widget.debugShowMaterialGrid,
            showPerformanceOverlay: widget.showPerformanceOverlay,
            checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
            showSemanticsDebugger: widget.showSemanticsDebugger,
            debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
            shortcuts: widget.shortcuts,
            actions: widget.actions,
            restorationScopeId: widget.restorationScopeId,
            scrollBehavior: widget.scrollBehavior,
            // ignore: deprecated_member_use
            useInheritedMediaQuery: widget.useInheritedMediaQuery,
          );
        },
      ),
    );
  }
}
