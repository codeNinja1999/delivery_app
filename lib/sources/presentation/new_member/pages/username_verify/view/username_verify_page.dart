import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import 'username_verify_form.dart';

class UsernameVerifyPage extends StatefulWidget {
  const UsernameVerifyPage({super.key});

  @override
  State<UsernameVerifyPage> createState() => _NewAccountMobileVerifyPageState();
}

class _NewAccountMobileVerifyPageState extends State<UsernameVerifyPage> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: MyAppBar(backButtonAction: () => Navigator.of(context, rootNavigator: true).pop()),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.hInset,
          right: context.hInsetR,
          top: AppSize.viewMargin,
          bottom: AppSize.bottomSafeInset,
        ),
        child: const UsernameVerifyForm(),
      ),
    );
  }
}
