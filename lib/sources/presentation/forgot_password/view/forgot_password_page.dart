import 'package:flutter/material.dart';

import '../route/reset_password_route.dart';
import '../route/reset_password_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var currentRoute = ResetPasswordRoute.verifyUserId;

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        if (currentRoute != ResetPasswordRoute.resetPassword) {
          _navigatorKey.currentState!.pop();
        }
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: ResetPasswordRoute.verifyUserId,
        onGenerateRoute: (setting) {
          currentRoute = setting.name ?? ResetPasswordRoute.verifyUserId;
          return ResetPasswordRouter.onGenerateRoute(setting, context);
        },
      ),
    );
  }
}
