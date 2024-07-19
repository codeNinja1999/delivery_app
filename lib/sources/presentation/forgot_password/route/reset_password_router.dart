import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/di/injector.dart';
import '../pages/verify_user_id/verify_user_id.dart';
import '../pages/otp_verify/otp_verify.dart';
import '../pages/reset_password/reset_password.dart';
import 'reset_password_route.dart';

class ResetPasswordRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case ResetPasswordRoute.verifyUserId:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<VerifyUserIdBloc>(),
            child: const VerifyUserIdPage(),
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
