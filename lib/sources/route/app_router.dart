import 'package:fresh_fold_delivery/sources/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/presentation/operator/bloc/operator_bloc.dart';
import 'package:fresh_fold_delivery/sources/presentation/operator/operator_page.dart';

import '../presentation/admin/admin_page.dart';
import '../presentation/admin/bloc/admin_bloc.dart';
import '../presentation/user/bloc/user_bloc.dart';
import '../presentation/forgot_password/forgot_password.dart';
import '../presentation/login/login.dart';
import '../presentation/new_member/new_member.dart';
import '../presentation/splash/splash.dart';
import '../presentation/user/view/user_page.dart';
import '../presentation/user_agreement/user_agreement.dart';
import 'app_route.dart';

T? tryCast<T>(dynamic object) => object is T ? object : null;

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case AppRoute.splash:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SplashBloc>(),
            child: const SplashPage(),
          ),
        );

      case AppRoute.user:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<UserBloc>(),
            child: const UserPage(),
          ),
        );

      case AppRoute.operator:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<OperatorBloc>(),
            child: const OperatorPage(),
          ),
        );
      case AppRoute.admin:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<AdminBloc>(),
            child: const AdminPage(),
          ),
        );

      case AppRoute.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<LoginBloc>(),
            child: const LoginPage(),
          ),
        );

      case AppRoute.newMemberPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<NewMemberBloc>(),
            child: const NewMemberPage(),
          ),
        );

      case AppRoute.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ForgotPasswordBloc>(),
            child: const ForgotPasswordPage(),
          ),
        );

      case AppRoute.userAgreement:
        final args = tryCast<String>(settings.arguments);
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<UserAgreementBloc>(),
            child: UserAgreementPage(title: args),
          ),
        );

      default:
        return MaterialPageRoute(builder: ((_) => Container(color: Colors.green)));
    }
  }

  static void logoutUser(BuildContext context) {
    sl.resetLazySingleton<UserUtilitiesRepository>();

    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(AppRoute.splash, (Route<dynamic> route) => false);
  }
}
