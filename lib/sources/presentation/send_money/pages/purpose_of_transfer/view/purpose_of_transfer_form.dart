import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/send_money_bloc.dart';
import '../bloc/purpose_of_transfer_bloc.dart';

class PurposeOfTransferForm extends StatefulWidget {
  const PurposeOfTransferForm({super.key});

  @override
  State<PurposeOfTransferForm> createState() => _PurposeOfTransferFormState();
}

class _PurposeOfTransferFormState extends State<PurposeOfTransferForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSize.inset),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _DepositMethodTypeInput(),
                  SizedBox(height: AppSize.inset),
                  _PurposeInput(),
                  _PurposeOfRemittanceOtherInput(),
                  _SourceInput(),
                  _SourceOfFundOtherInput(),
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
                  padding: const EdgeInsets.only(top: AppSize.viewSpacing, bottom: AppSize.viewSpacing),
                  child: BlocBuilder<PurposeOfTransferBloc, PurposeOfTransferState>(
                    builder: (context, state) {
                      return DividerButton(
                          backTitle: LocaleKeys.cancel.value,
                          backButtonAction: () => Navigator.of(context).pop(),
                          nextTitle: LocaleKeys.nextButtonTitle.value,
                          nextButtonAction: () {
                            KeyboardUtil.hideKeyboard(context);
                            if (formKey.currentState!.validate()) {
                              final mainState = context.read<SendMoneyBloc>().state;
                              context.read<PurposeOfTransferBloc>().add(
                                    SendMoney(
                                      purposeOfRemittance: state.purposeOfRemittance,
                                      sourceOfFunds: state.sourceOfFund,
                                      purposeOfRemittanceOther: state.purposeOfRemittanceOther,
                                      sourceOfFundsOther: state.sourceOfFundOther,
                                      detailedReceiver: mainState.detailedReceiver,
                                      promotionCode: mainState.promotionCode,
                                      calculateTransactionResult: mainState.calculateTransactionResult,
                                    ),
                                  );
                            }
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SourceOfFundOtherInput extends StatelessWidget {
  const _SourceOfFundOtherInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurposeOfTransferBloc, PurposeOfTransferState>(
      buildWhen: (previous, current) =>
          previous.sourceOfFund != current.sourceOfFund || previous.sourceOfFundOther != current.sourceOfFundOther,
      builder: (context, state) {
        return (state.sourceOfFund?.id == "99")
            ? Padding(
                padding: const EdgeInsets.only(top: AppSize.viewSpacing),
                child: AppTextfield(
                  maxLength: 100,
                  title: LocaleKeys.othersLabel.value,
                  cornerRadius: AppSize.cornerRadiusSmall,
                  placeHolder: LocaleKeys.specifyYourIncomeSource.value,
                  textInputType: TextInputType.text,
                  validator: (_) => state.sourceOfFundOtherValidation,
                  onChanged: (sourceOfFundOther) {
                    context.read<PurposeOfTransferBloc>().add(SourceOfFundOtherSelected(sourceOfFundOther));
                  },
                ),
              )
            : Container();
      },
    );
  }
}

class _PurposeOfRemittanceOtherInput extends StatelessWidget {
  const _PurposeOfRemittanceOtherInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurposeOfTransferBloc, PurposeOfTransferState>(
      buildWhen: (previous, current) =>
          previous.purposeOfRemittance != current.purposeOfRemittance ||
          previous.purposeOfRemittanceOther != current.purposeOfRemittanceOther,
      builder: (context, state) {
        return ((state.purposeOfRemittance?.id) == "99")
            ? Padding(
                padding: const EdgeInsets.only(top: AppSize.viewSpacing),
                child: AppTextfield(
                  title: LocaleKeys.othersLabel.value,
                  maxLength: 100,
                  placeHolder: LocaleKeys.specifyYourPurposeOfRemittance.value,
                  textInputType: TextInputType.text,
                  validator: (_) => state.purposeOfRemittanceOtherValidation,
                  onChanged: (purposeOfRemittanceOther) {
                    context.read<PurposeOfTransferBloc>().add(PurposeOfRemittanceOtherSelected(purposeOfRemittanceOther));
                  },
                ),
              )
            : Container();
      },
    );
  }
}

class _PurposeInput extends StatelessWidget {
  const _PurposeInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurposeOfTransferBloc, PurposeOfTransferState>(
      buildWhen: (previous, current) =>
          previous.purposeOfRemittanceList != current.purposeOfRemittanceList ||
          previous.purposeOfRemittance != current.purposeOfRemittance,
      builder: (context, state) {
        return AppDropDown<Catalog>(
          items: state.purposeOfRemittanceList,
          title: LocaleKeys.purposeOfTransfer.value,
          placeholder: LocaleKeys.selectPurposeOfTransferPlaceholder.value,
          validator: (_) => state.purposeOfRemitValidation,
          onChanged: (purposeOfRemittance) =>
              context.read<PurposeOfTransferBloc>().add(PurposeOfRemittanceSelected(purposeOfRemittance)),
          selectedItem: state.purposeOfRemittance,
          enableSearch: true,
        );
      },
    );
  }
}

class _DepositMethodTypeInput extends StatelessWidget {
  const _DepositMethodTypeInput();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.inset),
      child: BlocBuilder<PurposeOfTransferBloc, PurposeOfTransferState>(
        buildWhen: (previous, current) =>
            previous.depositMethodTypeList != current.depositMethodTypeList ||
            previous.depositMethodType != current.depositMethodType,
        builder: (context, state) {
          return AppDropDown<DepositType>(
            items: state.depositMethodTypeList,
            title: LocaleKeys.depositMethodType.value,
            placeholder: LocaleKeys.depositMethodTypePlaceholder.value,
            onChanged: (depositType) => context.read<PurposeOfTransferBloc>().add(DepositMethodTypeSelected(depositType)),
            enableSearch: true,
          );
        },
      ),
    );
  }
}

class _SourceInput extends StatelessWidget {
  const _SourceInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurposeOfTransferBloc, PurposeOfTransferState>(
      buildWhen: (previous, current) =>
          previous.sourceOfFundList != current.sourceOfFundList || previous.sourceOfFund != current.sourceOfFund,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: AppSize.inset),
          child: AppDropDown<Catalog>(
            title: LocaleKeys.sourceOfFund.value,
            placeholder: LocaleKeys.selectSourceOfFundPlaceholder.value,
            items: state.sourceOfFundList,
            validator: (_) => state.sourceOfFundValidation,
            onChanged: (sourceOfFunds) => context.read<PurposeOfTransferBloc>().add(SourceOfFundSelected(sourceOfFunds)),
            selectedItem: state.sourceOfFund,
            enableSearch: true,
          ),
        );
      },
    );
  }
}
