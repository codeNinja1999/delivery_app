import 'package:fresh_fold_delivery/sources/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/presentation/operator/bloc/operator_bloc.dart';
import 'package:fresh_fold_delivery/sources/presentation/operator/operator_page.dart';

import '../presentation/admin/admin_page.dart';
import '../presentation/admin/bloc/admin_bloc.dart';
import '../presentation/beneficiary/beneficiary.dart';
import '../presentation/user/bloc/user_bloc.dart';
import '../presentation/forgot_password/forgot_password.dart';
import '../presentation/history/history.dart';
import '../presentation/login/login.dart';
import '../presentation/new_member/new_member.dart';
import '../presentation/promotion/promotion.dart';
import '../presentation/promotion/view/promotion_page.dart';
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

        case AppRoute.starting:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => sl<PromotionBloc>(),
              child: const PromotionPage(),
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

        case AppRoute.beneficiaryList:
          return PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation1, animation2) => BlocProvider(
              create: (_) => sl<BeneficiaryListBloc>(),
              child: const BeneficiaryListPage(),
            ),
          );

        case AppRoute.createBeneficiary:
          final beneficiaryBloc = sl<BeneficiaryBloc>();
          final receiver = tryCast<DetailedReceiver>(settings.arguments);
          final initialDetails = tryCast<CalculateTransactionResult>(settings.arguments);
          beneficiaryBloc.add(AddInitialData(receiver: receiver, receiverData: initialDetails));

          return PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation1, animation2) => BlocProvider(
              create: (context) => beneficiaryBloc,
              child: CreateBeneficiaryPage(settings: settings),
            ),
          );

        case AppRoute.forgotPassword:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => sl<ForgotPasswordBloc>(),
              child: const ForgotPasswordPage(),
            ),
          );

        case AppRoute.transactionDetail:
          final transactionId = settings.arguments as String;
          final transactionDetailBloc = sl<TransactionDetailBloc>();
          transactionDetailBloc.transactionID = transactionId;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => transactionDetailBloc,
              child: const TransactionDetailPage(),
            ),
          );

        case AppRoute.beneficiaryDetail:
          final beneficiaryID = settings.arguments as String;
          final beneficiaryDetailBloc = sl<BeneficiaryDetailBloc>();
          beneficiaryDetailBloc.beneficiaryID = beneficiaryID;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => beneficiaryDetailBloc,
              child: const BeneficiaryDetailPage(),
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
    sl.resetLazySingleton<ReceiverRepository>();
    sl.resetLazySingleton<UserUtilitiesRepository>();
    sl.resetLazySingleton<TransactionActivityRepository>();

    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(AppRoute.splash, (Route<dynamic> route) => false);
  }
}
