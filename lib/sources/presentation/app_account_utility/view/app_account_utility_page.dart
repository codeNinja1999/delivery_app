import 'package:flutter/material.dart';

import '../route/route.dart';

class AppAccountUtilityPage extends StatefulWidget {
  const AppAccountUtilityPage({super.key, required this.settings});
  final RouteSettings settings;

  static SettingPageState of(BuildContext context) {
    return context.findAncestorStateOfType<SettingPageState>()!;
  }

  @override
  State<AppAccountUtilityPage> createState() => SettingPageState();
}

class SettingPageState extends State<AppAccountUtilityPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        _navigatorKey.currentState!.pop();
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: widget.settings.name,
        onGenerateRoute: (setting) {
          final newSettings = widget.settings;
          return AppAccountUtilityRouter.onGenerateRoute(newSettings, context);
        },
      ),
    );
  }
}
