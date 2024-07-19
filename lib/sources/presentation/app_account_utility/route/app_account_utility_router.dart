import 'package:fresh_fold_delivery/sources/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/account/account.dart';
import '../pages/change_language/change_language.dart';
import '../pages/change_password/change_password.dart';
import '../pages/contact_us/contact_us_page.dart';
import '../pages/help_center/help_center.dart';
import '../pages/notification/notification_page.dart';
import '../pages/user_personal_info/user_personal_info.dart';
import 'app_account_utility_route.dart';

class AppAccountUtilityRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case AppAccountUtilityRoute.account:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<AccountBloc>(),
            child: const AccountPage(),
          ),
        );

      case AppAccountUtilityRoute.changeLanguage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<ChangeLanguageBloc>(),
            child: const ChangeLanguagePage(),
          ),
        );

      case AppAccountUtilityRoute.profile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<UserPersonalInfoBloc>(),
            child: const UserPersonalInfoPage(),
          ),
        );

      case AppAccountUtilityRoute.notificationSetup:
        return MaterialPageRoute(
          builder: (_) => const NotificationPage(),
        );

      case AppAccountUtilityRoute.changePassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<ChangePasswordBloc>(),
            child: const ChangePasswordPage(),
          ),
        );

      case AppAccountUtilityRoute.helpCenter:
        return MaterialPageRoute(
          builder: (_) => const HelpCenterPage(),
        );

      case AppAccountUtilityRoute.faq:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<FaqBloc>(),
            child: const FaqsPage(),
          ),
        );

      // case AppAccountUtilityRoute.faqAnswer:
      //   final args = settings.arguments as AnswerModel;
      //   return MaterialPageRoute(
      //     builder: (_) => FaqAnswerPage(answerModel: args),
      //   );

      case AppAccountUtilityRoute.contactUs:
        return MaterialPageRoute(
          builder: (_) => const ContactUsPage(),
        );

      case AppAccountUtilityRoute.reportAProblem:
        return MaterialPageRoute(
          builder: (_) => const ReportAProblemPage(),
        );

      case AppAccountUtilityRoute.customerCare:
        return MaterialPageRoute(
          builder: (_) => const CustomerCarePage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Scope Waiting'))),
        );
    }
  }
}
