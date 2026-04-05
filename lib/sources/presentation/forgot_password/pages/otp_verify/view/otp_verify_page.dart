import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

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
    return AppPage(
      appBar: const MyAppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.hInset,
          right: context.hInsetR,
          bottom: AppSize.bottomSafeInset,
        ),
        child: const OtpVerifyForm(),
      ),
    );
  }
}
