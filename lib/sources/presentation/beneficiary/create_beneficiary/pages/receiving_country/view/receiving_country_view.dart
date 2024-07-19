import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/beneficiary_bloc.dart';
import '../../../widget/fraud_note.dart';
import '../bloc/receiving_country_bloc.dart';

class ReceivingCountryView extends StatefulWidget {
  const ReceivingCountryView({super.key});

  @override
  State<ReceivingCountryView> createState() => _ReceivingCountryViewState();
}

class _ReceivingCountryViewState extends State<ReceivingCountryView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();
    return Center(
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: AppSize.cornerRadiusMedium * 5,
          horizontal: AppSize.inset,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.inset),
          color: theme.colorScheme.surface,
        ),
        width: MediaQuery.of(context).size.width - AppSize.viewSpacing,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Choose receiving country",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: AppSize.inset),
                const FraudNotes(),
                const SizedBox(height: AppSize.inset),
                const ReceivingCountryInput(),
                const SizedBox(height: AppSize.viewSpacing),
                NextButtonView(formKey: formKey),
                const SizedBox(height: AppSize.inset),
                CustomButton(
                  title: LocaleKeys.cancel.value,
                  buttonType: ButtonType.plain,
                  textUnderline: false,
                  onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NextButtonView extends StatelessWidget {
  const NextButtonView({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceivingCountryBloc, ReceivingCountryState>(
      builder: (context, state) {
        return CustomButton(
          title: LocaleKeys.nextButtonTitle.value,
          onPressed: () {
            KeyboardUtil.hideKeyboard(context);
            if (formKey.currentState!.validate()) {
              context.read<BeneficiaryBloc>().add(SaveReceivingCountry(receivingCountry: state.receivingCountry));
              context.read<ReceivingCountryBloc>().add(ValidateReceivingCountry());
            }
          },
        );
      },
    );
  }
}

class ReceivingCountryInput extends StatelessWidget {
  const ReceivingCountryInput({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<ReceivingCountryBloc, ReceivingCountryState>(
      buildWhen: (previous, current) =>
          previous.receivingCountryList != current.receivingCountryList ||
          previous.receivingCountry != current.receivingCountry,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: AppSize.inset),
          child: AppDropDown<ReceivingCountry>(
            title: LocaleKeys.receivingCountryLabel.value,
            textStyle: theme.textTheme.bodyLarge,
            items: state.receivingCountryList,
            isCountry: true,
            selectedItem: state.receivingCountry,
            prefixIcon: (state.flag != null)
                ? Container(
                    padding: const EdgeInsets.only(left: AppSize.inset, right: AppSize.cornerRadiusMedium),
                    child: BorderImage(imageUrl: state.flag!, size: AppSize.inset * 2))
                : null,
            validator: (_) => state.receivingCountryValidation,
            prefixIconConstraints: const BoxConstraints(maxWidth: double.infinity),
            placeholder: LocaleKeys.receivingCountryPlaceholder.value,
            enableSearch: true,
            onChanged: (receivingCountry) {
              context.read<ReceivingCountryBloc>().add(ReceivingCountrySelected(receivingCountry));
            },
          ),
        );
      },
    );
  }
}
