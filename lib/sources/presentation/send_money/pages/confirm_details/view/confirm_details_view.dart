import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/send_money_bloc.dart';
import '../bloc/confirm_details_bloc.dart';
import 'summary_item_details.dart';

class ConfirmDetailsView extends StatelessWidget {
  const ConfirmDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSize.inset),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  LocaleKeys.transactionSummary.value,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSize.viewMargin),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: theme.disabledColor, blurRadius: 2, spreadRadius: 0)],
                    borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                    color: theme.colorScheme.surface,
                  ),
                  padding: const EdgeInsets.all(AppSize.inset),
                  child: BlocBuilder<SendMoneyBloc, SendMoneyState>(
                    builder: (context, state) {
                      final result = state.createdTransactionResult;
                      return Column(
                        children: [
                          SummaryItemView(
                            title: LocaleKeys.transferTo.value,
                            value: state.detailedReceiver?.personalInfo?.fullName ?? "",
                          ),
                          SummaryItemView(
                            title: LocaleKeys.recipientCountry.value,
                            value: state.detailedReceiver?.contactInfo?.receivingCountry.value ?? "",
                          ),
                          SummaryItemView(
                            title: LocaleKeys.receivingMethod.value,
                            value: result?.receiverResult?.payoutInfo?.mode?.value ?? "",
                          ),
                          SummaryItemView(
                            title: LocaleKeys.bankName.value,
                            value: result?.receiverResult?.payoutInfo?.bank?.value ?? "",
                          ),
                          (result?.receiverResult?.payoutInfo?.accountNumber != "")
                              ? SummaryItemView(
                                  title: LocaleKeys.accountNumber.value,
                                  value: result?.receiverResult?.payoutInfo?.accountNumber ?? "",
                                )
                              : Container(),
                          SummaryItemView(
                            title: LocaleKeys.receiveAmount.value,
                            value:
                                "${result?.receiverResult?.realAmount ?? ""} ${result?.receiverResult?.payoutInfo?.currency ?? ""}",
                          ),
                          SummaryItemView(
                            title: LocaleKeys.exchangeRate.value,
                            value: result?.currentRate ?? "",
                          ),
                          SummaryItemView(
                            title: LocaleKeys.transferAmount.value,
                            value:
                                "${StringUtils.formatDouble(result?.senderResult?.realAmount ?? "")} ${AppConstants.senderCurrencyCode}",
                          ),
                          SummaryItemView(
                            title: LocaleKeys.transferFee.value,
                            value: "${result?.serviceFee ?? ""} ${AppConstants.senderCurrencyCode}",
                          ),
                          Divider(color: theme.disabledColor),
                          const SizedBox(height: AppSize.cornerRadiusMedium),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                LocaleKeys.totalPayable.value,
                                style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
                              ),
                              Text(
                                "${StringUtils.formatDouble(result?.totalAmountToPay ?? "")} ${AppConstants.senderCurrencyCode}",
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.primary),
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          DividerButton(
              backTitle: LocaleKeys.cancel.value,
              nextTitle: LocaleKeys.payNow.value,
              nextButtonAction: () {
                context.read<ConfirmDetailsBloc>().add(ConfirmSendMoney(pinCode: ""));
              }),
        ],
      ),
    );
  }
}
