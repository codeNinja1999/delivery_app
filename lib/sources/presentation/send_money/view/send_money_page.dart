import 'package:flutter/material.dart';

import '../route/send_money_route.dart';
import '../route/send_money_router.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var currentRoute = SendMoneyRoute.exchangeRate;

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        if (currentRoute != SendMoneyRoute.success && currentRoute != SendMoneyRoute.confirmDetails) {
          _navigatorKey.currentState!.pop();
        }
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: SendMoneyRoute.exchangeRate,
        onGenerateRoute: (settings) {
          currentRoute = settings.name ?? SendMoneyRoute.exchangeRate;
          return SendMoneyRouter().onGenerateRoute(settings, context);
        },
      ),
    );
  }
}
