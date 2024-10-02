import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

class AddOperatorPage extends StatelessWidget {
  const AddOperatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const MyAppBar(
        title: "Add/Update Operator",
      ),
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.viewSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextfield(title: "Full Name"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "Phone Number"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "Phone Number"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "Email Address"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "Full address"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "New Password"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "Confirm Password"),
            const SizedBox(height: AppSize.inset),
            const SizedBox(height: AppSize.viewSpacing),
            CustomButton(backgroundColor: AppColors.primary, title: "Save Details", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
