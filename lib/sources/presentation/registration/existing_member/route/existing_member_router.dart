import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/di/injector.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import '../pages/id_validate/id_validate.dart';
import '../pages/new_password/new_password.dart';
import '../pages/selfie/selfie.dart';
import '../pages/verify_email/verify_email.dart';
import '../pages/verify_number/verify_number.dart';
import '../pages/verify_otp/verify_otp.dart';
import 'existing_member_route.dart';

class ExistingMemberRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case ExistingMemberRoute.verifyNumber:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<VerifyNumberBloc>(),
            child: const VerifyNumberPage(),
          ),
        );

      case ExistingMemberRoute.verifyOtp:
        final otpVerifyBloc = sl<VerifyOtpBloc>();
        final verificationType = settings.arguments as VerifyBy?;
        otpVerifyBloc.verificationType = verificationType;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => otpVerifyBloc,
            child: const VerifyOtpPage(),
          ),
        );

      case ExistingMemberRoute.validate:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<IdValidateBloc>(),
            child: const IdValidatePage(),
          ),
        );

      case ExistingMemberRoute.selfie:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SelfieBloc>(),
            child: const SelfiePage(),
          ),
        );

      case ExistingMemberRoute.confirmSelfie:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SelfieBloc>(),
            child: const ConfirmSelfiePage(),
          ),
        );

      case ExistingMemberRoute.verifyEmail:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<VerifyEmailBloc>(),
            child: const VerifyEmailPage(),
          ),
        );

      case ExistingMemberRoute.newPassword:
        final newPasswordBloc = sl<NewPasswordBloc>();
        final isSkip = settings.arguments as bool?;
        newPasswordBloc.isSkip = isSkip;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => newPasswordBloc,
            child: const NewPasswordPage(),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => Container(color: Colors.red));
    }
  }
}
