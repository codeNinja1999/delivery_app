import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fresh_fold_delivery/repository/domain/domain.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/send_money_bloc.dart';
import '../../../route/send_money_route.dart';
import '../bloc/exchange_rate_bloc.dart';
import 'receiving_amount_view.dart';
import 'sending_amount_view.dart';

class ExchangeRateView extends StatefulWidget {
  const ExchangeRateView({super.key});

  @override
  State<ExchangeRateView> createState() => _ExchangeRateViewState();
}

class _ExchangeRateViewState extends State<ExchangeRateView> {
  final receiveAmountEditingController = TextEditingController();
  final sendAmountEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExchangeRateBloc, ExchangeRateState>(
      listenWhen: (previous, current) =>
          previous.calculateTransactionResult != current.calculateTransactionResult || previous.status != current.status,
      listener: (context, state) {
        final calculationData = state.calculateTransactionResult;
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
        if (state.mode == CalculationMode.viaBase) {
          receiveAmountEditingController.text = calculationData?.receiverResult?.realAmount ?? "";
        } else if (state.mode == CalculationMode.viaCounter) {
          sendAmountEditingController.text = StringUtils.formatDouble(calculationData?.senderResult?.realAmount);
        }
      },
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSize.viewMargin),
                child: Column(
                  children: [
                    _ReceivingCountryInput(),
                    const SizedBox(height: AppSize.viewSpacing),
                    _ReceivingMethodInput(),
                    const SizedBox(height: AppSize.viewSpacing),
                    SendingAmount(
                      receiveAmountEditingController: receiveAmountEditingController,
                      sendAmountEditingController: sendAmountEditingController,
                    ),
                    const ExchangeRateSummary(),
                    ReceivingAmount(
                      receiveAmountEditingController: receiveAmountEditingController,
                      sendAmountEditingController: sendAmountEditingController,
                    ),
                    const SizedBox(height: AppSize.viewSpacing),
                    _PromoCodeInput(),
                    const SizedBox(height: AppSize.inset),
                  ],
                ),
              ),
              _ExchangeRateButtonView(formKey: formKey),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExchangeRateButtonView extends StatelessWidget {
  const _ExchangeRateButtonView({required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      buildWhen: (previous, current) =>
          previous.userInfo != current.userInfo ||
          previous.isPendingTransaction != current.isPendingTransaction ||
          previous.calculateTransactionResult != current.calculateTransactionResult,
      builder: (context, state) {
        return DividerButton(
          backTitle: LocaleKeys.cancel.value,
          nextTitle: LocaleKeys.nextButtonTitle.value,
          nextButtonAction: (state.amount != "") ? () => calculateAndSendMoney(context, state) : null,
          backButtonAction: () {
            KeyboardUtil.hideKeyboard(context);
            Navigator.of(context, rootNavigator: true).pop();
          },
        );
      },
    );
  }

  void calculateAndSendMoney(BuildContext context, ExchangeRateState state) {
    KeyboardUtil.hideKeyboard(context);
    if (formKey.currentState!.validate()) {
      final mainBloc = context.read<SendMoneyBloc>();
      (mainBloc.state.isReceiverResettable) ? mainBloc.add(SaveSelectedReceiver(detailedReceiver: null)) : null;
      mainBloc.add(
        SaveCalculateTransactionResult(
          calculateTransactionResult: state.calculateTransactionResult,
          promotionCode: state.promotionCode,
        ),
      );
      // if (state.isPendingTransaction) {
      //   showErrorMessage(context);
      // } else {
      if (state.calculateTransactionResult?.senderResult?.realAmount != null) {
        if (state.userInfo?.status == KYCStatus.verified) {
          (mainBloc.state.isSelected)
              ? Navigator.pushNamed(context, SendMoneyRoute.purposeOfTransfer)
              : Navigator.pushNamed(context, SendMoneyRoute.receiverList);
        } else {
          (state.userInfo?.status == KYCStatus.submitted) ? showKycSubmittedDialog(context) : showKycErrorDialog(context);
        }
      } else {
        SnackbarUtils.showSnackbar(
          context,
          message: LocaleKeys.amountIsRequired.value,
          icon: Icons.error,
          type: SnackBarType.error,
        );
      }
    }
    // }
  }

  showErrorMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (newContext) {
        return PopScope(
          canPop: false,
          child: CustomDialog(
            imageString: AppImages.warningImg,
            title: LocaleKeys.alertTitle.value,
            message: LocaleKeys.canNotSendMoneyWhenTransactionIsUnderPaymentProcess.value,
            primaryButtonTitle: LocaleKeys.doneButtonTitle.value,
            onPrimaryButtonPressed: () {},
          ),
        );
      },
    );
  }

  showKycErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: LocaleKeys.kycNotVerifiedTitle.value,
          imageString: AppImages.kycNotVerified,
          message: LocaleKeys.kycNotVerifiedMessage.value,
          primaryButtonTitle: LocaleKeys.verifyNowTitle.value,
          secondaryButtonTitle: LocaleKeys.skipIWillDoItLater.value,
          onPrimaryButtonPressed: () {
            Navigator.of(context).pushNamed(AppRoute.idVerification);
          },
        );
      },
    );
  }

  showKycSubmittedDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: LocaleKeys.kycNotVerifiedTitle.value,
          imageString: AppImages.kycNotVerified,
          message: LocaleKeys.kycVerificationIsInProcessingPleaseWait.value,
          primaryButtonTitle: LocaleKeys.goBack.value,
          onPrimaryButtonPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class _ReceivingMethodInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      buildWhen: (previous, current) =>
          previous.paymentModeList != current.paymentModeList || previous.paymentMode != current.paymentMode,
      builder: (context, state) {
        return AppDropDown<PaymentMode>(
          enabled: !(state.isBeneficiarySelected ?? false),
          title: LocaleKeys.receivingMethodLabel.value,
          items: state.paymentModeList ?? [],
          validator: (_) => state.paymentModeValidation,
          selectedItem: state.paymentMode,
          placeholder: LocaleKeys.selectMethod.value,
          enableSearch: true,
          onChanged: (paymentMode) {
            context.read<ExchangeRateBloc>().add(PaymentModeSelected(paymentMode));
          },
        );
      },
    );
  }
}

class _ReceivingCountryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      buildWhen: (previous, current) =>
          previous.receivingCountryList != current.receivingCountryList ||
          previous.receivingCountry != current.receivingCountry,
      builder: (context, state) {
        return AppDropDown<ReceivingCountry>(
          enabled: !(state.isBeneficiarySelected ?? false),
          title: LocaleKeys.receivingCountryLabel.value,
          items: state.receivingCountryList ?? [],
          isCountry: true,
          selectedItem: state.receivingCountry,
          prefixIcon: (state.flag != null)
              ? Container(
                  padding: const EdgeInsets.only(left: AppSize.inset, right: AppSize.cornerRadiusMedium),
                  child: BorderImage(
                    imageUrl: state.flag!,
                    size: AppSize.viewSpacing,
                  ))
              : null,
          validator: (_) => state.receivingCountryValidation,
          prefixIconConstraints: const BoxConstraints(maxWidth: double.infinity),
          placeholder: LocaleKeys.receivingCountryPlaceholder.value,
          enableSearch: true,
          onChanged: (receivingCountry) {
            context.read<ExchangeRateBloc>().add(ReceivingCountrySelected(receivingCountry));
          },
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
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      builder: (context, state) {
        final result = state.exchangeRateViewModel;

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
                    result?.exchangeRate ?? "0.0",
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
                    "${result?.transferFee ?? "0"} ${AppConstants.senderCurrencyCode}",
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
                    "${result?.totalAmountToPay ?? "0"} ${AppConstants.senderCurrencyCode}",
                    style:
                        theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: theme.colorScheme.primary),
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

class _PromoCodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.inset),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.inset * 0.75),
            color: theme.colorScheme.secondaryContainer,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Visibility(
                  visible: !(state.showDiscountPromo),
                  child: SvgPicture.asset(AppSvg.information, height: AppSize.viewSpacing),
                ),
                minLeadingWidth: 0,
                title: Text(
                  LocaleKeys.doYouHaveAPromoCode.value,
                  style: (state.showDiscountPromo) ? theme.textTheme.bodyLarge : theme.textTheme.bodyMedium,
                ),
                trailing: IconButton(
                  onPressed: () {
                    context.read<ExchangeRateBloc>().add(ShowDiscountPromoChanged(!state.showDiscountPromo));
                  },
                  icon: (state.showDiscountPromo)
                      ? const Icon(Icons.keyboard_arrow_up_outlined)
                      : const Icon(Icons.keyboard_arrow_down_outlined),
                ),
              ),
              (state.showDiscountPromo)
                  ? Column(
                      children: [
                        CustomTextField(
                          placeholder: LocaleKeys.enterPromoCodePlaceholder.value,
                          onChanged: (promoCode) => context.read<ExchangeRateBloc>().add(PromoCodeChanged(promoCode)),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              LocaleKeys.applyCode.value,
                              style: theme.textTheme.titleMedium?.copyWith(
                                decoration: TextDecoration.underline,
                                color: AppColors.hintTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
