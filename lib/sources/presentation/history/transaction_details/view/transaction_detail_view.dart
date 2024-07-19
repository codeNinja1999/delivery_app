import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/transaction_detail_bloc.dart';

class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
      builder: (context, state) {
        final detailViewModel = state.transactionDetailViewModel;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.viewMargin,
            vertical: AppSize.viewSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                LocaleKeys.transactionDetail.value,
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: AppSize.inset),
              ListItemViewDetail(
                title: LocaleKeys.dateOfTransaction.value,
                value: detailViewModel?.date,
              ),
              ListItemViewDetail(
                title: LocaleKeys.pinNumber.value,
                value: detailViewModel?.referenceNumber,
              ),
              ListItemViewDetail(
                title: LocaleKeys.transactionId.value,
                value: detailViewModel?.transactionID,
              ),
              ListItemViewDetail(
                title: LocaleKeys.receivingMethod.value,
                value: detailViewModel?.deliveryMethod ?? "",
              ),
              ListItemViewDetail(
                title: LocaleKeys.bankName.value,
                value: detailViewModel?.bank,
              ),
              (detailViewModel?.accountNumber != "")
                  ? ListItemViewDetail(
                      title: LocaleKeys.accountNumber.value,
                      value: detailViewModel?.accountNumber,
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSize.inset),
                child: Divider(color: theme.dividerColor, height: 1),
              ),
              ListItemViewDetail(
                title: LocaleKeys.exchangeRate.value,
                value: detailViewModel?.exchangeRate,
              ),
              ListItemViewDetail(
                title: LocaleKeys.transferAmount.value,
                value: detailViewModel?.sendAmount,
              ),
              ListItemViewDetail(
                title: LocaleKeys.transferFee.value,
                value: detailViewModel?.transferFee,
              ),
              ListItemViewDetail(
                title: LocaleKeys.receivingAmount.value,
                value: detailViewModel?.receiveAmount,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSize.inset),
                child: Divider(color: theme.dividerColor, height: 1),
              ),
              ListItemViewDetail(
                title: LocaleKeys.totalPayable.value,
                value: detailViewModel?.totalPaymentAmount,
                titleTextStyle: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
                valueTextStyle: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSize.inset),
                child: Divider(color: theme.dividerColor, height: 1),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ListItemViewDetail extends StatelessWidget {
  final String? title;
  final String? value;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;
  const ListItemViewDetail({
    super.key,
    this.title,
    this.value,
    this.titleTextStyle,
    this.valueTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSize.inset * 0.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title ?? "",
              style: (titleTextStyle != null) ? titleTextStyle : Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: Text(
              value ?? "",
              textAlign: TextAlign.end,
              style: (valueTextStyle != null) ? valueTextStyle : Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
