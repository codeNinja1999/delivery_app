import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class SecurityNotes extends StatelessWidget {
  const SecurityNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(AppSize.cornerRadiusSmall * 2),
      ),
      padding: const EdgeInsets.all(AppSize.inset),
      child: Row(
        children: [
          const Icon(Icons.lock, color: Colors.black, size: 20),
          const SizedBox(width: AppSize.cornerRadiusSmall),
          Expanded(
            child: Text(
              LocaleKeys.ensuringTheHighestLevelOfSecurity.value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
