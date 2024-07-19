import 'package:fresh_fold_delivery/sources/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import '../presentation/app_account_utility/app_account_utility.dart';
import '../presentation/beneficiary/beneficiary.dart';
import '../presentation/check_rate/check_rate.dart';
import '../presentation/currency_changer/currency_changer.dart';
import '../presentation/device_verification/device_verification.dart';
import '../presentation/registration/existing_member/existing_member.dart';
import '../presentation/forgot_password/forgot_password.dart';
import '../presentation/history/history.dart';
import '../presentation/home_tab/home_tab_bar.dart';
import '../presentation/kyc/kyc_verification.dart';
import '../presentation/login/login.dart';
import '../presentation/registration/new_member/new_member.dart';
import '../presentation/notification/notification.dart';
import '../presentation/promotion/promotion.dart';
import '../presentation/promotion/view/promotion_page.dart';
import '../presentation/send_money/send_money.dart';
import '../presentation/splash/splash.dart';
import '../presentation/user_agreement/user_agreement.dart';
import 'app_route.dart';

T? tryCast<T>(dynamic object) => object is T ? object : null;

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    if (settings.name?.startsWith("utility") ?? false) {
      return MaterialPageRoute(
        builder: (_) => AppAccountUtilityPage(settings: settings),
      );
    } else {
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

        case AppRoute.changeLanguage:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => sl<ChangeLanguageBloc>(),
              child: const ChangeLanguagePage(),
            ),
          );

        case AppRoute.checkRate:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => sl<CheckRateBloc>(),
              child: const CheckRatePage(),
            ),
          );

        case AppRoute.login:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => sl<LoginBloc>(),
              child: const LoginPage(),
            ),
          );

        case AppRoute.changeCurrency:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => sl<CurrencyChangerBloc>(),
              child: const CurrencyChangerPage(),
            ),
          );

        case AppRoute.idVerification:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => sl<KycVerificationBloc>(),
              child: const KycVerificationPage(),
            ),
          );

        case AppRoute.newMemberPage:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => sl<NewMemberBloc>(),
              child: const NewMemberPage(),
            ),
          );

        case AppRoute.existingMemberPage:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => sl<ExistingMemberBloc>(),
              child: const ExistingMemberPage(),
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

        case AppRoute.exchangeRate:
          return MaterialPageRoute(builder: ((_) => ExchangeRatePage(topUp: () {})));

        case AppRoute.newDeviceVerification:
          final deviceVerificationBloc = sl<DeviceVerificationBloc>();
          deviceVerificationBloc.loginViewModel = settings.arguments as LoginViewModel;
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: deviceVerificationBloc,
              child: const DeviceVerificationPage(),
            ),
          );

        case AppRoute.forgotPassword:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => sl<ForgotPasswordBloc>(),
              child: const ForgotPasswordPage(),
            ),
          );

        case AppRoute.home:
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => sl<HomeTabBarBloc>(),
              child: const HomeTabBar(),
            ),
          );

        case AppRoute.transactionList:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: sl<TransactionListBloc>(),
              child: const TransactionListPage(),
            ),
          );

        case AppRoute.imagePreview:
          final receiptImage = tryCast<String>(settings.arguments);
          return PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, animation1, animation2) {
              return ImagePreviewPage(receiptImage: receiptImage);
            },
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

        case AppRoute.uploadReceipt:
          final transactionId = tryCast<String>(settings.arguments);
          final bloc = sl<ReceiptBloc>();
          bloc.add(GetTransactionId(transactionId));
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => bloc,
              child: const ReceiptPage(),
            ),
          );

        case AppRoute.qrScan:
          final promptPayQR = settings.arguments as String;
          return MaterialPageRoute(builder: (_) => QrScanPage(promptPayQR: promptPayQR));

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

        case AppRoute.sendMoney:
          final args = settings.arguments as DetailedReceiver?;
          final sendMoneyBloc = sl<SendMoneyBloc>();
          sendMoneyBloc.add(SaveSelectedReceiver(detailedReceiver: args));
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) => sendMoneyBloc,
              child: const SendMoneyPage(),
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


        case AppRoute.notification:
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: sl<NotificationListBloc>(),
              child: const NotificationListPage(),
            ),
          );

        default:
          return MaterialPageRoute(builder: ((_) => Container(color: Colors.green)));
      }
    }
  }

  static void logoutUser(BuildContext context) {
    sl.resetLazySingleton<ReceiverRepository>();
    sl.resetLazySingleton<UserUtilitiesRepository>();
    sl.resetLazySingleton<TransactionActivityRepository>();

    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(AppRoute.splash, (Route<dynamic> route) => false);
  }
}
