import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import 'verify_email_form.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBar(backButtonAction: () => Navigator.of(context, rootNavigator: true).pop()),
      body: const VerifyEmailForm(),
    );
  }
}
