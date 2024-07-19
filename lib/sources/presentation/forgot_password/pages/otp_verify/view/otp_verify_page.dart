import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'otp_verify_form.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _NewAccountOtpVerifyPageState();
}

class _NewAccountOtpVerifyPageState extends State<OtpVerifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MyAppBar(),
      body: OtpVerifyForm(),
    );
  }
}
