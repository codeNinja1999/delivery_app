import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../bloc/send_money_bloc.dart';

class CurrentBalanceWidget extends StatelessWidget {
  const CurrentBalanceWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SendMoneyBloc, SendMoneyState>(
      builder: (context, state) {
        return Container(
          color: theme.colorScheme.primary.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: AppSize.inset),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LocaleKeys.yourBalance.value, style: theme.textTheme.bodyLarge),
              Row(
                children: [
                  Text(
                    (state.showAmount) ? LocaleKeys.amountPlaceHolder.value : "\$ ${14500.00}",
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    onPressed: () => context.read<SendMoneyBloc>().add(ShowAmountChanged(!state.showAmount)),
                    icon: (state.showAmount) ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                    color: theme.colorScheme.primary,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
