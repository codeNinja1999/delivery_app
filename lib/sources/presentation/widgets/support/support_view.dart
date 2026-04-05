import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key, this.onSupport});
  final VoidCallback? onSupport;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.cornerRadius - 4),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: ListTile(
        onTap: onSupport,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSize.inset, vertical: AppSize.cornerRadiusSmall),
        minLeadingWidth: 0,
        leading: Padding(
          padding: const EdgeInsets.only(bottom: AppSize.inset),
          child: Image.asset(AppImages.call, height: 18, width: 18, color: theme.colorScheme.primary),
        ),
        dense: true,
        title: Text(
          LocaleKeys.helpAndSupport.value,
          style: theme.textTheme.titleSmall,
        ),
        subtitle: Text(
          LocaleKeys.getQuickSolutionsForQueries.value,
          style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
