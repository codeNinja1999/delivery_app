import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/di/injector.dart';
import '../pages/verify_email/verify_email.dart';
import '../pages/otp_verify/otp_verify.dart';
import '../pages/reset_password/reset_password.dart';
import '../pages/verify_email/view/verify_email_page.dart';
import 'reset_password_route.dart';

class ResetPasswordRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case ResetPasswordRoute.verifyEmail:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<VerifyEmailBloc>(),
            child: const VerifyEmailPage(),
          ),
        );

      case ResetPasswordRoute.otpVerify:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<OtpVerifyBloc>(),
            child: const OtpVerifyPage(),
          ),
        );

      case ResetPasswordRoute.resetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ResetPasswordBloc>(),
            child: const ResetPasswordPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
