import 'package:flutter/material.dart';

import 'route/route.dart';

class KycVerificationPage extends StatefulWidget {
  const KycVerificationPage({super.key});

  @override
  State<KycVerificationPage> createState() => _KycVerificationPageState();
}

class _KycVerificationPageState extends State<KycVerificationPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var currentRoute = KycVerificationRoute.instruction;
  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        _navigatorKey.currentState!.pop();
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: KycVerificationRoute.instruction,
        onGenerateRoute: (settings) {
          currentRoute = settings.name ?? KycVerificationRoute.instruction;
          return KycVerificationRouter.onGenerateRoute(settings, context);
        },
      ),
    );
  }
}
