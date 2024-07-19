import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class ProgressIndicatorView extends StatelessWidget {
  const ProgressIndicatorView({super.key, required this.currentStep});
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.shadow,
      automaticallyImplyLeading: false,
      pinned: true,
      toolbarHeight: 90,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(AppSize.inset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.inset),
              child: StepProgressView(curStep: currentStep, color: theme.colorScheme.primary),
            ),
            // const SizedBox(height: AppSize.inset),
            // const CurrentBalanceWidget(),
          ],
        ),
      ),
    );
  }
}
