import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/receipt_bloc.dart';
import '../../../route/receipt_route.dart';
import '../bloc/deposit_bank_bloc.dart';

class DepositBankBody extends StatelessWidget {
  const DepositBankBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<DepositBankBloc, DepositBankState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          context.read<ReceiptBloc>().add(SaveDepositBank(state.depositBank));
          Navigator.pushNamed(context, ReceiptRoute.uploadReceipt);
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSize.viewSpacing,
            horizontal: AppSize.viewMargin,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _DepositBankInput(),
                    (state.depositBank != null) ? _SelectedDepositBankView() : Container(),
                    const SizedBox(height: AppSize.viewSpacing),
                    CustomInformationBox(
                      title: LocaleKeys.receiptInformationMessage.value,
                      titleTextStyle: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    BlocBuilder<DepositBankBloc, DepositBankState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(top: AppSize.viewSpacing),
                          child: CustomButton(
                            title: LocaleKeys.nextButtonTitle.value,
                            onPressed: () {
                              context.read<DepositBankBloc>().add(ValidateDepositType(state.depositBank));
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SelectedDepositBankView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<DepositBankBloc, DepositBankState>(
      buildWhen: (previous, current) => previous.depositBank != current.depositBank,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSize.viewSpacing),
            Text(
              "Account Number: ${state.depositBank?.accountno ?? ""}",
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSize.cornerRadiusMedium),
            (state.depositBank?.accountType != null && state.depositBank?.accountType != "")
                ? Padding(
                    padding: const EdgeInsets.only(bottom: AppSize.cornerRadiusMedium),
                    child: Text(
                      "Account Type: ${state.depositBank?.accountType ?? ""}",
                      style: theme.textTheme.bodyLarge,
                    ),
                  )
                : Container(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Name: ",
                  style: theme.textTheme.bodyLarge,
                ),
                Column(
                  children: [
                    Text(
                      state.depositBank?.accountName ?? "",
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      state.depositBank?.nativeAccountName ?? "",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _DepositBankInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepositBankBloc, DepositBankState>(
      buildWhen: (previous, current) =>
          previous.depositBankList != current.depositBankList || previous.depositBank != current.depositBank,
      builder: (context, state) {
        return AppDropDown<DepositBank>(
          title: "Deposit Bank Type",
          placeholder: "Select deposit bank type",
          items: state.depositBankList,
          onChanged: (depositBank) => context.read<DepositBankBloc>().add(DepositTypeChanged(depositBank)),
        );
      },
    );
  }
}
