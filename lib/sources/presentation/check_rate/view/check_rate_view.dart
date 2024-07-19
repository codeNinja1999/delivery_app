import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/check_rate_bloc.dart';
import 'receive_amount_view.dart';
import 'send_amount_view.dart';

class CheckRateView extends StatefulWidget {
  const CheckRateView({super.key});

  @override
  State<CheckRateView> createState() => _CheckRateViewState();
}

class _CheckRateViewState extends State<CheckRateView> {
  final receiveAmountEditingController = TextEditingController();
  final sendAmountEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckRateBloc, CheckRateState>(
      listenWhen: (previous, current) => previous.status != current.status || previous.mode != current.mode,
      listener: (context, state) {
        final status = state.status;
        final calculationData = state.calculateTransactionResult;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (state.mode == CalculationMode.viaBase) {
          receiveAmountEditingController.text = calculationData?.receiverResult?.realAmount ?? "";
        } else if (state.mode == CalculationMode.viaCounter) {
          sendAmountEditingController.text = StringUtils.formatDouble(calculationData?.senderResult?.realAmount);
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: Card(
          color: Colors.grey.shade100,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSize.viewMargin),
            child: Column(
              children: [
                SendingAmountView(
                  receiveAmountEditingController: receiveAmountEditingController,
                  sendAmountEditingController: sendAmountEditingController,
                ),
                _PayoutMethodInput(),
                ReceivingAmountView(
                  receiveAmountEditingController: receiveAmountEditingController,
                  sendAmountEditingController: sendAmountEditingController,
                ),
                const SizedBox(height: AppSize.viewSpacing),
                const ExchangeRateSummary(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PayoutMethodInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckRateBloc, CheckRateState>(
      buildWhen: (previous, current) =>
          previous.paymentModeList != current.paymentModeList || previous.paymentMode != current.paymentMode,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: AppSize.cornerRadiusMedium),
          child: Row(
            children: [
              Column(
                children: List.generate(
                  (state.paymentModeList != null)
                      ? (state.paymentModeList?.length ?? 0) > 2
                          ? (state.paymentModeList?.length ?? 0) + 5
                          : (state.paymentModeList?.length ?? 0) + 3
                      : 0,
                  (ii) => Padding(
                      padding: const EdgeInsets.only(left: 16, right: 0, top: 0, bottom: 10),
                      child: Container(
                        height: 8,
                        width: 2,
                        color: Colors.grey,
                      )),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: AppSize.cornerRadiusMedium),
                  itemCount: state.paymentModeList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final title = state.paymentModeList?[index].value;
                    return Theme(
                      data: ThemeData(
                        splashColor: Theme.of(context).colorScheme.shadow,
                        highlightColor: Theme.of(context).colorScheme.shadow,
                      ),
                      child: RadioListTile<PaymentMode>(
                        title: Text(title ?? ""),
                        activeColor: Theme.of(context).colorScheme.primary,
                        dense: true,
                        // tileColor: Colors.amber,
                        isThreeLine: false,
                        value: state.paymentModeList?[index] ?? const PaymentMode(id: "", value: ""),
                        groupValue: state.paymentMode,
                        onChanged: (paymentMode) {
                          context.read<CheckRateBloc>().add(PaymentModeSelected(paymentMode));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ExchangeRateSummary extends StatelessWidget {
  const ExchangeRateSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<CheckRateBloc, CheckRateState>(
      builder: (context, state) {
        final totalAmount = StringUtils.formatDouble(state.calculateTransactionResult?.totalAmountToPay);
        final result = state.calculateTransactionResult;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSize.inset),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.exchangeRate.value,
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    result?.currentRate ?? "0",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.cornerRadiusMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.transferFee.value,
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text(
                    "${result?.serviceFee ?? "0"} ${AppConstants.senderCurrencyCode}",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.cornerRadiusMedium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocaleKeys.youSendExactly.value,
                    style: theme.textTheme.bodyLarge?.copyWith(decoration: TextDecoration.underline),
                  ),
                  Text(
                    "$totalAmount ${AppConstants.senderCurrencyCode}",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
