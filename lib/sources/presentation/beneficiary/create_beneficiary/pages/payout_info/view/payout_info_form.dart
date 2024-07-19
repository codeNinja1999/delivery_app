import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/payout_info_bloc.dart';
import '../../../widget/fraud_note.dart';
import '../../../bloc/beneficiary_bloc.dart';
import '../../../route/beneficiary_route.dart';
import '../../receiving_country/bloc/receiving_country_bloc.dart';

class PayoutInfoForm extends StatefulWidget {
  const PayoutInfoForm({super.key});

  @override
  State<PayoutInfoForm> createState() => _PayoutInfoFormState();
}

class _PayoutInfoFormState extends State<PayoutInfoForm> {
  final formKey = GlobalKey<FormState>();
  final accountNumberEditingController = TextEditingController();
  final branchCodeEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<PayoutInfoBloc>();
    final mainState = context.read<BeneficiaryBloc>().state;
    bloc.add(GetBank(mainState.receivingCountry?.id, mainState.paymentMode));
    bloc.add(GetPayoutInfo(mainState.detailedReceiver, mainState.isEdit));
    accountNumberEditingController.text = mainState.detailedReceiver?.defaultPayoutInfo?.accountNumber ?? "";
    branchCodeEditingController.text = mainState.detailedReceiver?.defaultPayoutInfo?.branch?.id ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    accountNumberEditingController.dispose();
    branchCodeEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PayoutInfoBloc, PayoutInfoState>(
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          final mainBloc = context.read<BeneficiaryBloc>();
          var blocState = context.read<PayoutInfoBloc>().state;
          mainBloc.add(SaveBankDetail(blocState.payoutInfo));
          Navigator.pushNamed(context, BeneficiaryRoute.personalInfo);
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSize.viewSpacing,
                  horizontal: AppSize.viewMargin,
                ),
                child: Column(
                  children: [
                    Column(children: [
                      const FraudNotes(),
                      const SizedBox(height: AppSize.inset),
                      _BankInput(),
                      _BranchCodeInput(branchCodeEditingController),
                      const SizedBox(height: AppSize.viewSpacing),
                      _AccountNumberInput(accountNumberEditingController),
                      const SizedBox(height: AppSize.inset),
                    ]),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
                    child: ButtonView(formKey: formKey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonView extends StatelessWidget {
  const ButtonView({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Theme.of(context).disabledColor),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSize.viewSpacing,
            horizontal: AppSize.inset,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    KeyboardUtil.hideKeyboard(context);
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  title: LocaleKeys.backButtonTitle.value,
                  buttonType: ButtonType.bordered,
                ),
              ),
              const SizedBox(width: AppSize.inset),
              BlocBuilder<PayoutInfoBloc, PayoutInfoState>(
                builder: (context, state) {
                  return Expanded(
                    child: CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          KeyboardUtil.hideKeyboard(context);
                          context.read<PayoutInfoBloc>().add(SaveBankInfo());
                        }
                      },
                      title: LocaleKeys.nextButtonTitle.value,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AccountNumberInput extends StatelessWidget {
  const _AccountNumberInput(this.accountNumberController);
  final TextEditingController accountNumberController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayoutInfoBloc, PayoutInfoState>(
      buildWhen: (previous, current) => previous.accountNumber != current.accountNumber,
      builder: (context, state) {
        final mainState = context.read<BeneficiaryBloc>().state;
        final title = mainState.paymentType == PaymentType.bank
            ? LocaleKeys.accountNumberPlaceholder.value
            : LocaleKeys.walletIdTitle.value;
        final placeHolder =
            mainState.paymentType == PaymentType.bank ? LocaleKeys.enterAccountNumber.value : LocaleKeys.enterWalletId.value;
        return (mainState.paymentType != PaymentType.cash)
            ? AppTextfield(
                title: title,
                controller: accountNumberController,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))],
                placeHolder: placeHolder,
                validator: (_) => state.accountNumberValidation,
                onChanged: (accountNumber) => context.read<PayoutInfoBloc>().add(AccountNumberChanged(accountNumber)),
              )
            : Container();
      },
    );
  }
}

class _BankInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayoutInfoBloc, PayoutInfoState>(
      buildWhen: (previous, current) => previous.bankList != current.bankList || previous.bank != current.bank,
      builder: (context, state) {
        final mainState = context.read<BeneficiaryBloc>().state;
        final title = mainState.paymentType == PaymentType.bank
            ? LocaleKeys.bank.value
            : mainState.paymentType == PaymentType.cash
                ? LocaleKeys.payoutLocation.value
                : LocaleKeys.wallet.value;
        final placeHolder = mainState.paymentType == PaymentType.bank
            ? LocaleKeys.selectBank.value
            : mainState.paymentType == PaymentType.cash
                ? LocaleKeys.payoutLocation.value
                : LocaleKeys.wallet.value;
        return AppDropDown<Bank>(
          title: title,
          items: state.bankList,
          validator: (_) => (mainState.paymentType != PaymentType.bank)
              ? (mainState.paymentType != PaymentType.cash)
                  ? null
                  : state.payoutLocationValidation
              : state.bankValidation,
          selectedItem: state.bank,
          placeholder: placeHolder,
          enableSearch: true,
          onChanged: (bank) {
            context
                .read<PayoutInfoBloc>()
                .add(BankSelected(receivingCountryCode: mainState.receivingCountry?.id, bank: bank));
          },
        );
      },
    );
  }
}

class _BranchNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayoutInfoBloc, PayoutInfoState>(
      buildWhen: (previous, current) =>
          previous.branchList != current.branchList || previous.branch != current.branch || previous.bank != current.bank,
      builder: (context, state) {
        final mainState = context.read<BeneficiaryBloc>().state;
        final title = mainState.paymentType == PaymentType.bank
            ? LocaleKeys.branch.value
            : mainState.paymentType == PaymentType.cash
                ? LocaleKeys.payoutLocation.value
                : LocaleKeys.wallet.value;
        final placeHolder = mainState.paymentType == PaymentType.bank
            ? LocaleKeys.select.value
            : mainState.paymentType == PaymentType.cash
                ? LocaleKeys.payoutLocation.value
                : LocaleKeys.wallet.value;
        return AppDropDown<Branch>(
          title: title,
          items: state.branchList ?? [],
          selectedItem: state.branch,
          placeholder: placeHolder,
          enableSearch: true,
          onChanged: (branch) {
            context.read<PayoutInfoBloc>().add(BranchSelected(branch));
          },
        );
      },
    );
  }
}

class _BranchCodeInput extends StatelessWidget {
  const _BranchCodeInput(this.branchCodeEditingController);
  final TextEditingController branchCodeEditingController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayoutInfoBloc, PayoutInfoState>(
      buildWhen: (previous, current) => previous.branchCode != current.branchCode,
      builder: (context, state) {
        final receivingCountry = context.read<BeneficiaryBloc>().state.receivingCountry;
        final paymentType = context.read<BeneficiaryBloc>().state.paymentType;

        return Visibility(
          visible: visible(receivingCountry?.id, paymentType),
          child: Container(
            padding: const EdgeInsets.only(top: AppSize.viewSpacing),
            width: double.infinity,
            child: AppTextfield(
              cornerRadius: AppSize.cornerRadiusSmall,
              title: (receivingCountry?.id.toLowerCase() == "ind")
                  ? "${LocaleKeys.ifscCode.value}*"
                  : LocaleKeys.branchCode.value,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))],
              placeHolder: (receivingCountry?.id.toLowerCase() == "ind")
                  ? LocaleKeys.ifscCode.value
                  : LocaleKeys.branchCodeLabel.value,
              validator: (_) => (receivingCountry?.id.toLowerCase() == "ind")
                  ? state.ifscCodeValidation
                  : (receivingCountry?.id.toLowerCase() == "bgd" ||
                          receivingCountry?.id.toLowerCase() == "aus" ||
                          receivingCountry?.id.toLowerCase() == "lka")
                      ? state.branchCodeValidation
                      : null,
              onChanged: (branchCode) => context.read<PayoutInfoBloc>().add(BankBranchCodeChanged(branchCode)),
              controller: branchCodeEditingController,
            ),
          ),
        );
      },
    );
  }

  bool visible(String? id, PaymentType? paymentMethod) {
    if ((id == "IND" || id == "BGD" || id == "AUS" || id == "LKA") && paymentMethod == PaymentType.bank) {
      return true;
    } else {
      return false;
    }
  }
}
