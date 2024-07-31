import 'package:flutter/material.dart';

import 'route/operator_route.dart';
import 'route/operator_router.dart';

class OperatorPage extends StatefulWidget {
  const OperatorPage({super.key});

  @override
  State<OperatorPage> createState() => _OperatorPageState();
}

class _OperatorPageState extends State<OperatorPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var currentRoute = OperatorRoute.dashboard;

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        _navigatorKey.currentState!.pop();
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: OperatorRoute.dashboard,
        onGenerateRoute: (setting) {
          currentRoute = setting.name ?? OperatorRoute.dashboard;
          return OperatorRouter.onGenerateRoute(setting, context);
        },
      ),
    );
  }
}
