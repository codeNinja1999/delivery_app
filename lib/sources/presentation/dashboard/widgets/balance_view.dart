import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/dashboard_bloc.dart';

class BalanceView extends StatelessWidget {
  const BalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final theme = Theme.of(context);

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              LocaleKeys.yourBalance.value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Text(
                  (state.showAmount)
                      ? LocaleKeys.amountPlaceHolder.value
                      : "¥ ${state.userInfo?.walletInfo?.amount ?? "0.00"}",
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: 32),
                ),
                IconButton(
                  icon:
                      (state.showAmount) ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined),
                  color: theme.colorScheme.primary,
                  onPressed: () {
                    context.read<DashboardBloc>().add(ShowAmountChanged(!state.showAmount));
                  },
                ),
              ],
            ),
            Text(
              "${LocaleKeys.pending.value}: ${(state.showAmount) ? LocaleKeys.amountPlaceHolder.value : "\$ ${state.userInfo?.walletInfo?.amountPending ?? "0.00"}"}",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      },
    );
  }
}
