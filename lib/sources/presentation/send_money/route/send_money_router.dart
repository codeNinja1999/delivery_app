import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/di/injector.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';
import '../bloc/send_money_bloc.dart';
import '../pages/confirm_details/confirm_details.dart';
import '../pages/exchange_rate/exchange_rate.dart';
import '../pages/purpose_of_transfer/purpose_of_transfer.dart';
import '../pages/receiver_list/receiver_list.dart';
import '../pages/success/success.dart';
import 'send_money_route.dart';

class SendMoneyRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings, BuildContext context) {
    switch (settings.name) {
      case SendMoneyRoute.receiverList:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ReceiverListBloc>(),
            child: ReceiverListPage(
              onCreateBeneficiary: (_) {
                Navigator.pushNamed(
                  context,
                  AppRoute.createBeneficiary,
                  arguments: context.read<SendMoneyBloc>().state.calculateTransactionResult,
                );
              },
            ),
          ),
        );

      case SendMoneyRoute.purposeOfTransfer:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<PurposeOfTransferBloc>(),
            child: const PurposeOfTransferPage(),
          ),
        );

      case SendMoneyRoute.exchangeRate:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ExchangeRateBloc>(),
            child: ExchangeRatePage(
              topUp: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, AppRoute.topUp);
              },
            ),
          ),
        );

      case SendMoneyRoute.confirmDetails:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<ConfirmDetailsBloc>(),
            child: const ConfirmDetailsPage(),
          ),
        );

      case SendMoneyRoute.success:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SendMoneySuccessBloc>(),
            child: const SendMoneySuccessPage(),
          ),
        );

      case SendMoneyRoute.invoice:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<SendMoneySuccessBloc>(),
            child: const InvoicePage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
