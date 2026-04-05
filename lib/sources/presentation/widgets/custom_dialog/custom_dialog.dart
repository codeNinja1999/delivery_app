import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    this.imageString,
    this.svgImage,
    required this.message,
    required this.primaryButtonTitle,
    this.secondaryButtonTitle,
    required this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
  });

  final String title;
  final String? imageString;
  final String? svgImage;
  final String message;
  final String primaryButtonTitle;
  final String? secondaryButtonTitle;
  final Function() onPrimaryButtonPressed;
  final Function()? onSecondaryButtonPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 40, horizontal: AppSize.inset),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.inset),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        width: MediaQuery.of(context).size.width - 24,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: theme.colorScheme.shadow,
                child: (imageString != null)
                    ? Image.asset(imageString ?? AppImages.dashboardCard, fit: BoxFit.contain)
                    : SvgPicture.asset(svgImage ?? AppSvg.receiptSuccess, fit: BoxFit.contain),
              ),
              const SizedBox(height: AppSize.inset),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: AppSize.inset),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.cornerRadiusMedium),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: AppSize.viewMargin),
              CustomButton(
                title: primaryButtonTitle,
                onPressed: () {
                  Navigator.of(context).pop();
                  onPrimaryButtonPressed();
                },
              ),
              (secondaryButtonTitle != null)
                  ? Padding(
                      padding: const EdgeInsets.only(top: AppSize.inset),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (onSecondaryButtonPressed != null) {
                            onSecondaryButtonPressed!();
                          }
                        },
                        child: Text(
                          secondaryButtonTitle!,
                          style: theme.textTheme.titleMedium?.copyWith(
                            decoration: TextDecoration.underline,
                            color: AppColors.hintTextColor,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
