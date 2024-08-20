import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

class AddServicePricePage extends StatelessWidget {
  const AddServicePricePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: const MyAppBar(
        title: "Add Price",
      ),
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.viewSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextfield(title: "Service Type"),
            AppTextfield(title: "Price"),
            const SizedBox(height: AppSize.viewSpacing),
            CustomButton(backgroundColor: AppColors.primary, title: "Save Price", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
