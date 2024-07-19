import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class DividerButton extends StatelessWidget {
  const DividerButton({
    super.key,
    this.backTitle,
    this.backButtonAction,
    this.nextTitle,
    required this.nextButtonAction,
  });

  final String? backTitle;
  final Function()? backButtonAction;
  final String? nextTitle;
  final Function()? nextButtonAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(color: theme.disabledColor),
        Padding(
          padding: const EdgeInsets.all(AppSize.inset),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              (backTitle != null)
                  ? DefaultBackButtonAction(backTitle: backTitle, backButtonAction: backButtonAction)
                  : Container(),
              Expanded(
                child: CustomButton(
                  title: nextTitle ?? "Continue",
                  onPressed: (nextButtonAction != null)
                      ? () {
                          KeyboardUtil.hideKeyboard(context);
                          nextButtonAction!();
                        }
                      : null,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class DefaultBackButtonAction extends StatelessWidget {
  const DefaultBackButtonAction({
    super.key,
    required this.backTitle,
    required this.backButtonAction,
  });

  final String? backTitle;
  final Function()? backButtonAction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              title: backTitle!,
              onPressed: (backButtonAction != null)
                  ? backButtonAction
                  : () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                              svgImage: AppSvg.cancel,
                              title: LocaleKeys.cancelTransaction.value,
                              message: LocaleKeys.areYouSureYouWantToCancelThisTransaction.value,
                              primaryButtonTitle: LocaleKeys.yesCancel.value,
                              secondaryButtonTitle: LocaleKeys.noIWantToContinue.value,
                              onPrimaryButtonPressed: backButtonAction ??
                                  () {
                                    Navigator.of(context).pop();
                                  });
                        },
                      );
                    },
              buttonType: ButtonType.bordered,
            ),
          ),
          const SizedBox(width: AppSize.inset),
        ],
      ),
    );
  }
}
