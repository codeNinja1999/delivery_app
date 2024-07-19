import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class FailureCustomDialog extends StatelessWidget {
  const FailureCustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 20, horizontal: AppSize.viewSpacing),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.inset),
          color: theme.colorScheme.surface,
        ),
        height: 426,
        width: 343,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSize.viewMargin),
              const CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 25,
                  child: Icon(
                    Icons.close,
                    size: 25,
                    weight: 60.0,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: AppSize.viewMargin, bottom: AppSize.viewMargin),
                child: Text("Saving failed", style: theme.textTheme.titleMedium?.copyWith(fontSize: 20)),
              ),
              Text(
                "Sorry! We’re not being able to process your query at the moment. Please try again later or contact support for help.",
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
                "Skip, I’ll do it later",
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
