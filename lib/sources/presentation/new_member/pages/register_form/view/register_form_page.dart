import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import 'register_form_view.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterPersonalInfoPageState();
}

class _RegisterPersonalInfoPageState extends State<RegisterFormPage> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: MyAppBar(backButtonAction: cancelRegistration),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.hInset,
          right: context.hInsetR,
          bottom: AppSize.bottomSafeInset,
        ),
        child: const RegisterForm(),
      ),
    );
  }

  void cancelRegistration() {
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
