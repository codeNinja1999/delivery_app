import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(backButtonAction: () => Navigator.of(context, rootNavigator: true).pop()),
      body: const UsernameVerifyForm(),
    );
  }
}
