import 'package:flutter/material.dart';

import '../route/route.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var currentRoute = ReceiptRoute.uploadReceipt;
  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        _navigatorKey.currentState!.pop();
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: ReceiptRoute.uploadReceipt,
        onGenerateRoute: (setting) {
          currentRoute = setting.name ?? ReceiptRoute.uploadReceipt;
          return ReceiptRouter.onGenerateRoute(setting, context);
        },
      ),
    );
  }
}
