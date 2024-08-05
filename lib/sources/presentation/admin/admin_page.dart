import 'package:flutter/material.dart';

import 'route/admin_route.dart';
import 'route/user_router.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var currentRoute = AdminRoute.adminDashboard;

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        _navigatorKey.currentState!.pop();
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: AdminRoute.adminDashboard,
        onGenerateRoute: (setting) {
          currentRoute = setting.name ?? AdminRoute.adminDashboard;
          return AdminRouter.onGenerateRoute(setting, context);
        },
      ),
    );
  }
}
