import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_core.dart';
import '../../../widgets/widgets.dart';
import '../../bloc/kyc_verification_bloc.dart';

import '../../route/kyc_verification_route.dart';
import '../bloc/current_address_bloc.dart';

class CurrentAddressForm extends StatefulWidget {
  const CurrentAddressForm({super.key});

  @override
  State<CurrentAddressForm> createState() => _CurrentAddressFormState();
}

class _CurrentAddressFormState extends State<CurrentAddressForm> {
  final _formKey = GlobalKey<FormState>();
  final stateEditingController = TextEditingController();
  final cityEditingController = TextEditingController();
  final zipCodeEditingController = TextEditingController();
  final streetAddressEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<CurrentAddressBloc>();
    bloc.add(CurrentAddressSubscriptionRequested());
  }

  @override
  void dispose() {
    super.dispose();
    stateEditingController.dispose();
    cityEditingController.dispose();
    zipCodeEditingController.dispose();
    streetAddressEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<CurrentAddressBloc, CurrentAddressState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is SetAddressSuccess) {
          zipCodeEditingController.text = state.zipCode;
          stateEditingController.text = state.state ?? "";
          cityEditingController.text = state.city;
          streetAddressEditingController.text = state.streetAddress;
          cityEditingController.text = state.city;
        } else if (status is PostalAddressSelectedSuccess) {
          zipCodeEditingController.text = state.zipCode;
          stateEditingController.text = state.state ?? "";
          cityEditingController.text = state.city;
          streetAddressEditingController.text = state.streetAddress;
          cityEditingController.text = state.city;
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: BlocBuilder<CurrentAddressBloc, CurrentAddressState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.viewMargin,
                      vertical: AppSize.viewSpacing,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          LocaleKeys.currentResidentialAddress.value,
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: AppSize.inset),
                        Text(
                          LocaleKeys.provideCurrentResidentialAddressInformation.value,
                          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: AppSize.viewMargin),
                        _ZipCodeInput(zipCodeEditingController),
                        const SizedBox(height: AppSize.inset),
                        _StateInput(stateEditingController),
                        const SizedBox(height: AppSize.viewSpacing),
                        _CityInput(cityEditingController),
                        const SizedBox(height: AppSize.inset),
                        _StreetAddressInput(streetAddressEditingController),
                        const SizedBox(height: AppSize.viewSpacing),
                        CustomInformationBox(title: LocaleKeys.whyIsThisNeeded.value),
                      ],
                    ),
                  ),
                  DividerButton(
                    backTitle: LocaleKeys.back.value,
                    nextTitle: LocaleKeys.nextButtonTitle.value,
                    backButtonAction: () => Navigator.of(context).pop(),
                    nextButtonAction: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<KycVerificationBloc>().add(
                              SaveAddressInfo(
                                state: state.state,
                                zipCode: state.zipCode,
                                streetAddress: state.streetAddress,
                                city: state.city,
                                japaneseStreetAddress: state.japaneseStreetAddress,
                                japaneseSenderAddress: state.japaneseSenderAddress,
                              ),
                            );
                        Navigator.of(context).pushNamed(KycVerificationRoute.idSelection);
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ZipCodeInput extends StatelessWidget {
  const _ZipCodeInput(this.zipController);
  final TextEditingController zipController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentAddressBloc, CurrentAddressState>(
      buildWhen: (previous, current) => previous.zipCode != current.zipCode,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${LocaleKeys.zipCodeLabel.value}*",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSize.inset * 0.75),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomTextField(
                    placeholder: LocaleKeys.zipCodePlaceholder.value,
                    cornerRadius: AppSize.cornerRadiusSmall,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    textController: zipController,
                    textInputType: TextInputType.number,
                    maxLength: 8,
                    validator: (_) => state.zipCodeValidation,
                    onChanged: (zipCode) => context.read<CurrentAddressBloc>().add(ZipCodeChanged(zipCode)),
                  ),
                ),
                const SizedBox(width: AppSize.inset),
                CustomButton(
                  onPressed: state.zipCode != ""
                      ? () {
                          KeyboardUtil.hideKeyboard(context);
                          context.read<CurrentAddressBloc>().add(SearchPostalAddress());
                        }
                      : null,
                  title: LocaleKeys.search.value,
                  backgroundColor: state.zipCode != ""
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.4),
                  padding: const EdgeInsets.all(AppSize.cornerRadiusMedium),
                  cornerRadius: AppSize.cornerRadiusMedium,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _StreetAddressInput extends StatelessWidget {
  const _StreetAddressInput(this.streetAddressController);
  final TextEditingController streetAddressController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentAddressBloc, CurrentAddressState>(
      builder: (context, state) {
        return AppTextfield(
          title: "${LocaleKeys.streetAddress.value}*",
          placeHolder: LocaleKeys.streetAddressPlaceholder.value,
          controller: streetAddressController,
          onChanged: (streetAddress) => context.read<CurrentAddressBloc>().add(StreetAddressChanged(streetAddress)),
          validator: (_) => state.streetAddressValidation,
        );
      },
    );
  }
}

class _CityInput extends StatelessWidget {
  const _CityInput(this.cityController);
  final TextEditingController cityController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentAddressBloc, CurrentAddressState>(
      buildWhen: (previous, current) => previous.city != current.city,
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.cityPlaceHolder.value,
          placeHolder: LocaleKeys.cityPlaceHolder.value,
          controller: cityController,
          onChanged: (city) => context.read<CurrentAddressBloc>().add(CityChanged(city)),
          validator: (_) => state.cityValidation,
        );
      },
    );
  }
}

class _StateInput extends StatelessWidget {
  const _StateInput(this.stateController);
  final TextEditingController stateController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentAddressBloc, CurrentAddressState>(
      builder: (context, state) {
        return AppTextfield(
          title: "${LocaleKeys.stateLabel.value}*",
          placeHolder: LocaleKeys.statePlaceholder.value,
          cornerRadius: AppSize.cornerRadiusSmall,
          validator: (_) => state.stateValidation,
          controller: stateController,
          onChanged: (state) {
            context.read<CurrentAddressBloc>().add(StateSelected(state));
          },
        );
      },
    );
  }
}
