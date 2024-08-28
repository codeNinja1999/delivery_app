import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import 'account_otp_verify_form.dart';

class AccountOtpVerifyPage extends StatefulWidget {
  const AccountOtpVerifyPage({super.key});

  @override
  State<AccountOtpVerifyPage> createState() => _AccountOtpVerifyPageState();
}

class _AccountOtpVerifyPageState extends State<AccountOtpVerifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MyAppBar(),
      body: const OtpVerifyForm(),
    );
  }
}
