import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

import '../../route/operator_route.dart';

class ShortcutActionView extends StatelessWidget {
  const ShortcutActionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, OperatorRoute.pickupOrder);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppSize.viewMargin,
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
                    "New Pickup: 3",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSize.inset),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, OperatorRoute.history);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppSize.inset,
                horizontal: AppSize.viewSpacing,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.inset),
                color: Theme.of(context).scaffoldBackgroundColor,
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
                    "Overall History",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
