import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import '../bloc/exchange_rate_bloc.dart';

Timer? _debounce;

class ReceivingAmount extends StatelessWidget {
  const ReceivingAmount({
    super.key,
    required this.receiveAmountEditingController,
    required this.sendAmountEditingController,
  });

  final TextEditingController receiveAmountEditingController;
  final TextEditingController sendAmountEditingController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
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
                  onTap: () => receiveAmountEditingController.selection =
                      TextSelection(baseOffset: 0, extentOffset: (receiveAmountEditingController.text).length),
                  keyboardType: TextInputType.number,
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: AppSize.viewMargin),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "0.00",
                    hintStyle: theme.textTheme.titleMedium?.copyWith(fontSize: AppSize.viewMargin),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(AppRegex.floatDigit),
                    DecimalTextInputFormatter(),
                  ],
                  controller: receiveAmountEditingController,
                  onChanged: (value) {
                    if (value != "") {
                      receiveAmountEditingController.text = value;
                      (_debounce?.isActive ?? false) ? _debounce?.cancel() : null;
                      _debounce = Timer(
                        const Duration(milliseconds: 500),
                        () => context.read<ExchangeRateBloc>().add(CalculateTransaction(
                              calculationMode: CalculationMode.viaCounter,
                              amount: value,
                            )),
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

class ReceiverCurrencyView extends StatelessWidget {
  const ReceiverCurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      buildWhen: (previous, current) =>
          previous.flag != current.flag || previous.receivingCountry != current.receivingCountry,
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (state.flag != null) ? BorderImage(imageUrl: state.flag!, size: AppSize.inset * 2) : Container(),
            const SizedBox(width: AppSize.cornerRadiusMedium),
            Text(
              state.receivingCountry?.currencyCode ?? "",
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        );
      },
    );
  }
}
