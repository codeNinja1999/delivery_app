import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'sources/config/config.dart';
import 'sources/core/app_core.dart';
import 'sources/di/injector.dart' as di;
import 'sources/route/route.dart';

final AppNavigatorObserver routeObserver = AppNavigatorObserver();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  await initializeApp();
  runApp(configureApp());
}

Future<void> initializeApp() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final packageInfo = await PackageInfo.fromPlatform();
  AppConfig.initialize(version: packageInfo.version);
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
}

Widget configureApp() {
  return EasyLocalization(
    supportedLocales: const [Locale('en', 'USA')],
    fallbackLocale: const Locale('en', 'USA'),
    path: "assets/language",
    child: ChangeNotifierProvider(
      create: (_) => ThemeConfig(),
      child: const FreshFoldApp(),
    ),
  );
}

class FreshFoldApp extends StatefulWidget {
  const FreshFoldApp({super.key});

  @override
  FreshFoldAppState createState() => FreshFoldAppState();
}

class FreshFoldAppState extends State<FreshFoldApp> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // ignore: avoid_print
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        // ignore: avoid_print
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        // ignore: avoid_print
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        // ignore: avoid_print
        print("app in detached");
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  Widget appBuilder(BuildContext context, Widget? child) {
    final easyChild = EasyLoading.init()(context, child);

    final themeMode = context.watch<ThemeConfig>().themeMode;

    // Wrapping global system UI overlay
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppOverlays.of(context, mode: themeMode),
      child: easyChild,
    );
  }

  @override
  Widget build(BuildContext context) {
    _initializeUI();


    final themeMode = context.watch<ThemeConfig>().themeMode;

    return GestureDetector(
      onTap: _handleTap(context),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        builder: appBuilder,
        navigatorObservers: [routeObserver],
        onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings, context),
        initialRoute: AppRoute.splash,
      ),
    );
  }

  void _initializeUI() {
    AppSize().init(context);
  }

  VoidCallback _handleTap(BuildContext context) {
    return () {
      if (FocusScope.of(context).hasFocus) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    };
  }
}
