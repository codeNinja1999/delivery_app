import 'package:flutter/material.dart';
import '../route/route.dart';

class ExistingMemberPage extends StatefulWidget {
  const ExistingMemberPage({super.key});

  @override
  State<ExistingMemberPage> createState() => _ExistingMemberPageState();
}

class _ExistingMemberPageState extends State<ExistingMemberPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var currentRoute = ExistingMemberRoute.verifyNumber;

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        if (currentRoute != ExistingMemberRoute.validate) {
          _navigatorKey.currentState!.pop();
        }
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: ExistingMemberRoute.verifyOtp,
        onGenerateRoute: (settings) {
          currentRoute = settings.name ?? ExistingMemberRoute.verifyNumber;
          return ExistingMemberRouter.onGenerateRoute(settings, context);
        },
      ),
    );
  }
}
