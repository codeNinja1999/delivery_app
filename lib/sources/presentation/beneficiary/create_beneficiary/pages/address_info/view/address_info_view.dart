import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/beneficiary_bloc.dart';
import '../../../widget/fraud_note.dart';
import '../bloc/address_info_bloc.dart';

class AddressInfoView extends StatefulWidget {
  const AddressInfoView({super.key});

  @override
  State<AddressInfoView> createState() => _AddressInfoViewState();
}

class _AddressInfoViewState extends State<AddressInfoView> {
  final formKey = GlobalKey<FormState>();
  final zipCodeEditingController = TextEditingController();
  final statesEditingController = TextEditingController();
  final streetAddressEditingController = TextEditingController();

  void successDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (newContext) {
        final state = context.read<AddressInfoBloc>().state;

        return PopScope(
          canPop: false,
          child: CustomDialog(
            imageString: AppImages.beneficiarySuccess,
            title: (state.isEdit) ? LocaleKeys.beneficiaryUpdated.value : LocaleKeys.beneficiarySaved.value,
            message: (state.isEdit) ? LocaleKeys.beneficiaryUpdatedMessage.value : LocaleKeys.beneficiaryAddedMessage.value,
            primaryButtonTitle: (state.fromSendMoney) ? LocaleKeys.doneButtonTitle.value : LocaleKeys.sendMoneyNow.value,
            secondaryButtonTitle: (state.fromSendMoney) ? null : LocaleKeys.skipIWillDoItLater.value,
            onPrimaryButtonPressed: () async {
              if (state.fromSendMoney) {
                Navigator.of(context, rootNavigator: true).pop();
              } else {
                Navigator.of(context, rootNavigator: true)
                    .popAndPushNamed(AppRoute.sendMoney, arguments: state.detailedReceiver, result: true);
              }
            },
            onSecondaryButtonPressed:
                (state.fromSendMoney) ? null : () => Navigator.of(context, rootNavigator: true).pop(true),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    final mainState = context.read<BeneficiaryBloc>().state;
    if (mainState.isEdit) {
      zipCodeEditingController.text = mainState.detailedReceiver?.contactInfo?.postalCode ?? "";
      statesEditingController.text = mainState.detailedReceiver?.contactInfo?.state?.id ?? "";
      streetAddressEditingController.text = mainState.detailedReceiver?.contactInfo?.streetAddress ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressInfoBloc, AddressInfoState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          successDialog();
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
                      _ZipCodeInput(zipCodeEditingController),
                      const SizedBox(height: AppSize.inset),
                      _StateInput(statesEditingController),
                      const SizedBox(height: AppSize.viewSpacing),
                      _StreetAddressInput(streetAddressEditingController),
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
                    child: SubmitButtonView(formKey: formKey),
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

class SubmitButtonView extends StatelessWidget {
  const SubmitButtonView({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(color: Theme.of(context).dividerColor.withOpacity(0.3)),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSize.viewSpacing,
            horizontal: AppSize.inset,
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    KeyboardUtil.hideKeyboard(context);
                    Navigator.of(context).pop();
                  },
                  title: LocaleKeys.backButtonTitle.value,
                  buttonType: ButtonType.bordered,
                ),
              ),
              const SizedBox(width: AppSize.inset),
              Expanded(
                child: BlocBuilder<AddressInfoBloc, AddressInfoState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: () {
                        KeyboardUtil.hideKeyboard(context);
                        if (formKey.currentState!.validate()) {
                          final mainState = context.read<BeneficiaryBloc>().state;
                          context.read<AddressInfoBloc>().add(
                                ProcessBeneficiary(
                                  receiver: mainState.data(state.addressData),
                                  receiverId: mainState.detailedReceiver?.id ?? "",
                                ),
                              );
                        }
                      },
                      title: LocaleKeys.submit.value,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ZipCodeInput extends StatelessWidget {
  const _ZipCodeInput(this.zipCodeController);
  final TextEditingController zipCodeController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressInfoBloc, AddressInfoState>(
      buildWhen: (previous, current) => previous.zipCode != current.zipCode,
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.zipCodeLabel.value,
          controller: zipCodeController,
          placeHolder: LocaleKeys.zipCodePlaceholder.value,
          // validator: (_) => state.zipCodeValidation,
          onChanged: (zipCode) => context.read<AddressInfoBloc>().add(ZipCodeChanged(zipCode)),
        );
      },
    );
  }
}

class _StateInput extends StatelessWidget {
  const _StateInput(this.statesController);
  final TextEditingController statesController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressInfoBloc, AddressInfoState>(
      buildWhen: (previous, current) => previous.states != current.states,
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.state.value,
          controller: statesController,
          placeHolder: LocaleKeys.statePlaceholder.value,
          onChanged: (states) =>
              context.read<AddressInfoBloc>().add(StateChanged(states: States(id: states, value: states))),
          // validator: (_) => state.stateValidation,
        );
        // AppDropDown<States>(
        //   title: "State",
        //   selectedItem: state.states,
        //   placeholder: "Enter state",
        //   // validator: (_) => state.stateValidation,
        //   items: state.statesList,
        //   onChanged: (states) => context.read<AddressInfoBloc>().add(StateChanged(states)),
        // );
      },
    );
  }
}

class _StreetAddressInput extends StatelessWidget {
  const _StreetAddressInput(this.addressController);
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressInfoBloc, AddressInfoState>(
      buildWhen: (previous, current) => previous.address != current.address,
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.streetAddressLabel.value,
          controller: addressController,
          placeHolder: "Enter street address",
          onChanged: (value) => context.read<AddressInfoBloc>().add(AddressChanged(value)),
          validator: (_) => state.addressValidation,
        );
      },
    );
  }
}
