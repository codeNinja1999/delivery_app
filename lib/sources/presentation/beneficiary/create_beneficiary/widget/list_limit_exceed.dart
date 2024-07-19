import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class ListLimitExceed extends StatelessWidget {
  const ListLimitExceed({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 20,
          horizontal: AppSize.viewSpacing,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.inset),
          color: theme.colorScheme.surface,
        ),
        height: 426,
        width: 343,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.limitAlert,
                height: 100,
                width: 100,
              ),
              Text("Beneficiary Limit Exceeded", style: theme.textTheme.titleLarge),
              const SizedBox(height: AppSize.viewMargin),
              Text(
                "You can only add ten beneficiaries. Please contact support if you want to add more than ten beneficiaries.",
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.viewMargin),
              CustomButton(
                title: "Contact support",
                onPressed: () {},
                buttonType: ButtonType.round,
              ),
              const SizedBox(height: AppSize.inset),
              Text(
                "Cancel",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.hintTextColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
