import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

class PriceEditPage extends StatelessWidget {
  const PriceEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: darkTheme,
      child: Scaffold(
        appBar: MyAppBar(
          title: "Add Price",
          // backButtonBackgroundColor: AppColors.backgroundContainerLight,
          backButtonBackgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18, color: AppColors.whiteColor),
          // backgroundColor: AppColors.backgroundDark,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
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
      ),
    );
  }
}
