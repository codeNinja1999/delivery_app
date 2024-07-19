import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/verify_otp_bloc.dart';
import 'verify_otp_form.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  @override
  void initState() {
    super.initState();
    context.read<VerifyOtpBloc>().add(GetVerificationType());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MyAppBar(),
      body: const VerifyOtpForm(),
      resizeToAvoidBottomInset: false,
    );
  }
}
