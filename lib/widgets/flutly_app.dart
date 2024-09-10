import 'package:easy_localization/easy_localization.dart';
import 'package:flutly/core/flutly_theme.dart';
import 'package:flutly/core/flutly_transaction.dart';
import 'package:flutly/flutly.dart';
import 'package:flutly/main.dart';
import 'package:flutly/test/four_page.dart';
import 'package:flutly/test/main_page.dart';
import 'package:flutly/test/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class FlutlyApp extends StatefulWidget {
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
  final Iterable<Locale> supportedLocales;
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
  final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
         pageBuilder: (BuildContext context, GoRouterState state) {
          return FlutlyTransaction.getDefaultTransaction(
              state.pageKey, const MainPage());
        },
      ),
      GoRoute(
        path: '/second',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return FlutlyTransaction.getDefaultTransaction(
              state.pageKey, const SecondPage());
        },
      ),
      GoRoute(
        path: '/four',
         pageBuilder: (BuildContext context, GoRouterState state) {
          return FlutlyTransaction.getDefaultTransaction(
              state.pageKey, const FourPage());
        },
      ),
    ],
  );

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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            scaffoldMessengerKey: widget.scaffoldMessengerKey,
            backButtonDispatcher: widget.backButtonDispatcher,
            routerConfig: _router,
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
