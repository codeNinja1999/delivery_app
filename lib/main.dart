import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'sources/config/config.dart';
import 'sources/core/app_core.dart';
import 'sources/di/injector.dart' as di;
import 'sources/route/route.dart';

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
    super.didChangeAppLifecycleState(state);
    final stateDescriptions = {
      AppLifecycleState.resumed: "app in resumed",
      AppLifecycleState.inactive: "app in inactive",
      AppLifecycleState.paused: "app in paused",
      AppLifecycleState.detached: "app in detached",
      AppLifecycleState.hidden: null,
    };
    final message = stateDescriptions[state];
    if (message != null) {
      print(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initializeUI(context);

    return GestureDetector(
      onTap: _handleTap(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        builder: EasyLoading.init(),
        navigatorObservers: [AppNavigatorObserver()],
        onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings, context),
        initialRoute: AppRoute.splash,
      ),
    );
  }

  void _initializeUI(BuildContext context) {
    AppSize().init(context);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  VoidCallback _handleTap(BuildContext context) {
    return () {
      if (FocusScope.of(context).hasFocus) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    };
  }
}
