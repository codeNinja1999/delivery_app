import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/core/helper/helper.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import 'login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // ← already popped, skip

        await AppExitHelper.handleBackPress(context);
      },
      child: AppPage(
        body: Padding(
          padding: EdgeInsets.only(
            left: context.hInset,
            right: context.hInsetR,
            bottom: AppSize.bottomSafeInset,
          ),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
