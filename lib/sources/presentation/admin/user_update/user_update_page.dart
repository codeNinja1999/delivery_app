import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

class UserUpdatePage extends StatelessWidget {
  const UserUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const MyAppBar(
        title: "Update User",
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.viewSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextfield(title: "Email"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "First Name"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "Middle Name"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "Last Name"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "User Name"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "Password"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "Confirm Password"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "Phone Number"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(title: "Location"),
            const SizedBox(height: AppSize.viewSpacing),
            CustomButton(backgroundColor: AppColors.primary, title: "Save Details", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
