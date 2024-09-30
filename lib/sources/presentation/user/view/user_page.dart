import 'package:flutter/material.dart';

import '../route/user_route.dart';
import '../route/user_router.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var currentRoute = UserRoute.dashboard;

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        if (currentRoute != UserRoute.orderSuccess) {
          _navigatorKey.currentState!.maybePop();
        }
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: UserRoute.dashboard,
        onGenerateRoute: (setting) {
          currentRoute = setting.name ?? UserRoute.dashboard;
          return UserRouter.onGenerateRoute(setting, context);
        },
      ),
    );
  }
}
