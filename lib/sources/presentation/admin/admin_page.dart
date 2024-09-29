import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';

import 'route/admin_route.dart';
import 'route/admin_router.dart';

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
    return Theme(
      data: darkTheme,
      child: NavigatorPopHandler(
        onPop: () {
          _navigatorKey.currentState!.maybePop();
        },
        child: Navigator(
          key: _navigatorKey,
          initialRoute: AdminRoute.adminDashboard,
          onGenerateRoute: (setting) {
            currentRoute = setting.name ?? AdminRoute.adminDashboard;
            return AdminRouter.onGenerateRoute(setting, context);
          },
        ),
      ),
    );
  }
}
