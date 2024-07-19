import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/di/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/account_otp_verify/account_otp_verify.dart';
import '../pages/confirm_pin/confirm_pin_page.dart';
import '../pages/register_form/register_form.dart';
import '../pages/set_biometrics/set_biometrics_page.dart';
import '../pages/set_pin/set_pin.dart';
import '../pages/username_verify/username_verify.dart';
import 'new_member_route.dart';

class NewMemberRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case NewMemberRoute.newUsernameVerify:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<UsernameVerifyBloc>(),
            child: const UsernameVerifyPage(),
          ),
        );

      case NewMemberRoute.otpVerify:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AccountOtpVerifyBloc>(),
            child: const AccountOtpVerifyPage(),
          ),
        );

      case NewMemberRoute.registerForm:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<RegisterFormBloc>(),
            child: const RegisterFormPage(),
          ),
        );

      case NewMemberRoute.setNetPin:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SetPinBloc>(),
            child: const SetPinPage(),
          ),
        );

      case NewMemberRoute.confirmPin:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SetPinBloc>(),
            child: const ConfirmTransactionPinPage(),
          ),
        );

      case NewMemberRoute.setBiometrics:
        return MaterialPageRoute(
          builder: (_) => const SetBiometricsPage(),
        );

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
