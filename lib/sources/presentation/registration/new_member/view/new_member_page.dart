import 'package:flutter/material.dart';

import '../new_member.dart';

class NewMemberPage extends StatefulWidget {
  const NewMemberPage({super.key});

  @override
  State<NewMemberPage> createState() => _NewMemberPageState();
}

class _NewMemberPageState extends State<NewMemberPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  var currentRoute = NewMemberRoute.newUsernameVerify;

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      onPop: () {
        if (currentRoute != NewMemberRoute.registerForm) {
          _navigatorKey.currentState!.pop();
        }
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: NewMemberRoute.newUsernameVerify,
        onGenerateRoute: (settings) {
          currentRoute = settings.name ?? NewMemberRoute.newUsernameVerify;
          return NewMemberRouter.onGenerateRoute(settings, context);
        },
      ),
    );
  }
}
