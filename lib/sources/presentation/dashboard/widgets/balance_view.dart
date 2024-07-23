import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';
import 'package:fresh_fold_delivery/sources/route/app_route.dart';
import '../bloc/dashboard_bloc.dart';

class BalanceView extends StatelessWidget {
  const BalanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final theme = Theme.of(context);

        return Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSize.inset,
                  horizontal: AppSize.viewSpacing,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.inset),
                  color: theme.colorScheme.primary,
                  border: Border.all(color: theme.colorScheme.outline),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_reaction,
                      size: AppSize.viewSpacing,
                      color: AppColors.whiteColor,
                    ),
                    const SizedBox(height: AppSize.cornerRadiusMedium),
                    Text(
                      "New Order",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(height: AppSize.cornerRadiusSmall),
                    Text(
                      "Do my Laundry",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSize.inset),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.orderHistory);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSize.inset,
                    horizontal: AppSize.viewSpacing,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.inset),
                    color: theme.colorScheme.surfaceContainer,
                    border: Border.all(color: theme.colorScheme.outline),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.history,
                        size: AppSize.viewSpacing,
                      ),
                      const SizedBox(height: AppSize.cornerRadiusMedium),
                      Text(
                        "Order History",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSize.cornerRadiusSmall),
                      Text(
                        "View past order",
                        style: theme.textTheme.bodyMedium?.copyWith(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
