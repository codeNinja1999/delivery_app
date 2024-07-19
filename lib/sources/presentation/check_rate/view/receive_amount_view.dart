import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/check_rate_bloc.dart';

Timer? _debounce;

class ReceivingAmountView extends StatelessWidget {
  const ReceivingAmountView({
    super.key,
    required this.receiveAmountEditingController,
    required this.sendAmountEditingController,
  });

  final TextEditingController receiveAmountEditingController;
  final TextEditingController sendAmountEditingController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(LocaleKeys.recipientGets.value, style: theme.textTheme.bodyLarge),
          const SizedBox(height: AppSize.cornerRadiusMedium),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.inset),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
              border: Border.all(color: theme.disabledColor),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                const ReceiverCurrencyView(),
                Expanded(
                  child: TextFormField(
                    onTap: () => receiveAmountEditingController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: receiveAmountEditingController.text.length,
                    ),
                    keyboardType: TextInputType.number,
                    style: theme.textTheme.titleMedium?.copyWith(fontSize: AppSize.viewMargin),
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "0.00",
                      hintStyle: theme.textTheme.titleMedium?.copyWith(fontSize: AppSize.viewMargin),
                    ),
                    controller: receiveAmountEditingController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(AppRegex.floatDigit),
                      DecimalTextInputFormatter(),
                    ],
                    onChanged: (value) {
                      if (value != "") {
                        receiveAmountEditingController.text = value;
                        (_debounce?.isActive ?? false) ? _debounce?.cancel() : null;
                        _debounce = Timer(
                          const Duration(milliseconds: 500),
                          () => context
                              .read<CheckRateBloc>()
                              .add(CalculateTransaction(calculationMode: CalculationMode.viaCounter, amount: value)),
                        );
                      } else {
                        (_debounce?.isActive ?? false) ? _debounce?.cancel() : null;
                      }
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

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Check if the new value matches the regex pattern
    if (AppRegex.floatDigit.hasMatch(newValue.text)) {
      // Ensure there's only one decimal point
      if (newValue.text.split('.').length > 2) {
        return oldValue;
      }
      return newValue;
    }
    return oldValue;
  }
}

class ReceiverCurrencyView extends StatefulWidget {
  const ReceiverCurrencyView({super.key});

  @override
  State<ReceiverCurrencyView> createState() => _ReceiverCurrencyViewState();
}

class _ReceiverCurrencyViewState extends State<ReceiverCurrencyView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckRateBloc, CheckRateState>(
      buildWhen: (previous, current) =>
          previous.receivingCountry != current.receivingCountry ||
          previous.receivingCountryList != current.receivingCountryList,
      builder: (context, state) {
        return SizedBox(
          width: 100,
          height: 50,
          child: DropdownButton<ReceivingCountry>(
            value: state.receivingCountry ?? state.receivingCountryList?.first,
            elevation: 0,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: state.dropdownList,
            underline: const SizedBox(),
            onChanged: (receivingCountry) {
              context.read<CheckRateBloc>().add(ReceivingCountrySelected(receivingCountry));
            },
          ),
        );
      },
    );
  }
}
