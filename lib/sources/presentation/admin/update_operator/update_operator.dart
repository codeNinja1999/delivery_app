import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

class UpdateOperatorPage extends StatelessWidget {
  const UpdateOperatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const MyAppBar(
        title: "Update Operator",
      ),
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.viewSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextfield(title: "Full Name"),
            AppTextfield(title: "Phone Number"),
            AppTextfield(title: "Phone Number"),
            AppTextfield(title: "Email Address"),
            AppTextfield(title: "Full address"),
            AppTextfield(title: "New Password"),
            AppTextfield(title: "Confirm Password"),
            const SizedBox(height: AppSize.viewSpacing),
            CustomButton(backgroundColor: AppColors.primary, title: "Save Details", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
