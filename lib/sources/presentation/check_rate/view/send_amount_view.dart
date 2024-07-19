import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/check_rate_bloc.dart';

Timer? _debounce;

class SendingAmountView extends StatelessWidget {
  const SendingAmountView({
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
        Text(LocaleKeys.youSend.value, style: theme.textTheme.bodyLarge),
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
              const CurrencyView(),
              Expanded(
                child: TextFormField(
                  onTap: () => sendAmountEditingController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: sendAmountEditingController.text.length,
                  ),
                  keyboardType: TextInputType.number,
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: AppSize.viewMargin),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "0.00",
                    hintStyle: theme.textTheme.titleMedium?.copyWith(fontSize: AppSize.viewMargin),
                  ),
                  controller: sendAmountEditingController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value != "") {
                      final newString = AmountHelper.formatAmount(value.replaceAll(',', ''));
                      sendAmountEditingController.text = newString;
                      (_debounce?.isActive ?? false) ? _debounce?.cancel() : null;
                      _debounce = Timer(
                        const Duration(milliseconds: 1000),
                        () => context
                            .read<CheckRateBloc>()
                            .add(CalculateTransaction(calculationMode: CalculationMode.viaBase, amount: value)),
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

class CurrencyView extends StatelessWidget {
  const CurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BorderImage(
          imageUrl: AppConstants.defaultFlagUrl,
          size: AppSize.inset * 2,
        ),
        const SizedBox(width: AppSize.cornerRadiusMedium),
        Text(
          AppConstants.senderCurrencyCode,
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
