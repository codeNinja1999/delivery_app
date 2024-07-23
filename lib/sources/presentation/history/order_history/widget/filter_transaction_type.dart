import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class FilterTransactionType extends StatelessWidget {
  final String title;
  final int selectedIndex;
  final int currentIndex;
  final Function()? onTap;
  const FilterTransactionType({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.selectedIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: AppSize.cornerRadiusMedium),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          side: BorderSide(color: theme.colorScheme.primary),
          backgroundColor: (selectedIndex == currentIndex) ? theme.colorScheme.primary : theme.colorScheme.surface,
          padding: const EdgeInsets.symmetric(
            vertical: AppSize.cornerRadiusMedium,
            horizontal: AppSize.inset,
          ),
        ),
        child: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: (selectedIndex == currentIndex) ? theme.colorScheme.surface : theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
