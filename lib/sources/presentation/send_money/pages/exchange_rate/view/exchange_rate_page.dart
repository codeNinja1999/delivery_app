import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/send_money_bloc.dart';
import '../bloc/exchange_rate_bloc.dart';
import 'exchange_rate_view.dart';

class ExchangeRatePage extends StatefulWidget {
  final Function() topUp;

  const ExchangeRatePage({super.key, required this.topUp});

  @override
  State<ExchangeRatePage> createState() => _ExchangeRatePageState();
}

class _ExchangeRatePageState extends State<ExchangeRatePage> {
  @override
  void initState() {
    super.initState();
    context.read<ExchangeRateBloc>().add(UserInfoSubscription());
    context.read<ExchangeRateBloc>().add(GetTransactionListInfo());
    context.read<ExchangeRateBloc>().add(TransactionListSubscriptionRequested());
    isReceiverSelected();
  }

  isReceiverSelected() {
    final mainState = context.read<SendMoneyBloc>().state;
    final bloc = context.read<ExchangeRateBloc>();

    if (mainState.isSelected) {
      bloc.add(ReceiverSelectedChanged(mainState.isSelected));
      bloc.add(ReceivingCountrySelected(mainState.detailedReceiver?.contactInfo?.receivingCountry));
      bloc.add(PaymentModeSelected(mainState.detailedReceiver?.defaultPayoutInfo?.mode));
    } else {
      bloc.add(GetReceivingCountry());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: LocaleKeys.sendMoney.value,
        backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const ProgressIndicatorView(currentStep: 1),
          ];
        },
        body: const ExchangeRateView(),
      ),
    );
  }
}
