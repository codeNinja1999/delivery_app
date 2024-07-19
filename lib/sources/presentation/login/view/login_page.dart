import 'package:flutter/material.dart';

import 'login_app_bar.dart';
import 'login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: Theme.of(context).colorScheme.primary,
          actions: const [LoginAppBar()],
          elevation: 0,
        ),
        body: const LoginForm(),
      ),
    );
  }
}
