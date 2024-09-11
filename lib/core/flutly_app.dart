import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/core/flutly_app_bar.dart';
import 'package:flutly/core/flutly_bottom_bar.dart';
import 'package:flutly/core/flutly_config.dart';
import 'package:flutly/core/flutly_page.dart';
import 'package:flutly/core/flutly_theme.dart';
import 'package:flutly/core/flutly_transaction.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/models/flutly_bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class FlutlyApp extends StatefulWidget {
  final List<FlutlyPage> pages;
  final FlutlyBottomBar? bottomBar;
  final FlutlyAppBar? appBar;
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

    for (var route in widget.pages) {
      routes.add(
        GoRoute(
          name: route.name,
          path: route.path,
          onExit: route.onExit,
          pageBuilder: (BuildContext context, GoRouterState state) {
            Get.find<FlutlyConfig>().setCurrentRoute(state.path!);
            return FlutlyTransaction.getDefaultTransaction(
                state.pageKey, route.page);
          },
        ),
      );
    }

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
                    Get.find<FlutlyConfig>().setCurrentRoute(state.fullPath!);
                    return FlutlyTransaction.getFadeTransaction(
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
                Get.find<FlutlyConfig>().setCurrentRoute(state.fullPath!);
                return FlutlyTransaction.getFadeTransaction(
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
              return Scaffold(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                bottomNavigationBar: Container(
                  width: double.infinity,
                  height: widget.bottomBar!.height ?? 80,
                  color: widget.bottomBar!.color ?? Colors.black,
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < widget.bottomBar!.items.length; i++)
                          GestureDetector(
                            onTap: () {
                              if (widget.bottomBar!.items[i].page.path !=
                                  Get.find<FlutlyConfig>().getCurrentRoute()) {
                                context
                                    .go(widget.bottomBar!.items[i].page.path);
                              }
                            },
                            child: SizedBox(
                              width: 50,
                              height: double.infinity,
                              child: Center(
                                child: SizedBox(
                                  width: widget.bottomBar!.itemSize ?? 30,
                                  height: widget.bottomBar!.itemSize ?? 30,
                                  child: widget.bottomBar!.items[i].activePath,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  child: Column(
                    children: [
                      widget.appBar != null
                          ? GetBuilder<FlutlyConfig>(
                              builder: (controller) {
                                FlutlyBottomBarItem? item = widget.bottomBar!
                                    .getItemWithPath(
                                        controller.getCurrentRoute());
                                if (item == null) return const SizedBox();
                                if (widget.appBar!.isAnimated()) {
                                  return AnimatedContainer(
                                    width: double.infinity,
                                    height: item.appBarHeight ?? 80,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOutCubic,
                                    alignment: Alignment.center,
                                    color: widget.appBar!.color ??
                                        Theme.of(context)
                                            .appBarTheme
                                            .backgroundColor,
                                    child: SafeArea(child: item.appBar!),
                                  );
                                }
                                return Container(
                                  width: double.infinity,
                                  height: item.appBarHeight ?? 80,
                                  alignment: Alignment.center,
                                  color: widget.appBar!.color ??
                                      Theme.of(context)
                                          .appBarTheme
                                          .backgroundColor,
                                  child: SafeArea(child: item.appBar!),
                                );
                              },
                            )
                          : Container(
                              width: double.infinity,
                              height: 50,
                              color: widget.appBar!.color ??
                                  Theme.of(context).appBarTheme.backgroundColor,
                            ),
                      Flexible(
                        child: SizedBox.expand(
                          child: child,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    }

    router = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: routes,
    );

    super.initState();
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
            title: 'Flutter Demo',
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
