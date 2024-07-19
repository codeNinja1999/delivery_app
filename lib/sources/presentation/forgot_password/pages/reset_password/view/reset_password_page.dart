import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import 'reset_password_form.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(backButtonAction: cancelNewPasswordDialog),
      body: const ResetPasswordForm(),
    );
  }

  void cancelNewPasswordDialog() {
    showDialog(
      context: context,
      builder: (newContext) {
        return CustomDialog(
          svgImage: AppSvg.cancel,
          title: LocaleKeys.cancel.value,
          message: LocaleKeys.areYouSureYouWantToCancel.value,
          primaryButtonTitle: LocaleKeys.yesCancel.value,
          secondaryButtonTitle: LocaleKeys.noIWantToContinue.value,
          onPrimaryButtonPressed: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}
