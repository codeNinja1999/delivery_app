import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/app_core.dart';
import '../../../../../resources/resources.dart';
import '../../../../widgets/widgets.dart';

class SetBiometricsPage extends StatefulWidget {
  const SetBiometricsPage({super.key});

  @override
  State<SetBiometricsPage> createState() => _SetBiometricsPageState();
}

class _SetBiometricsPageState extends State<SetBiometricsPage> {
  final formKey = GlobalKey<FormState>();

  void _showRegisterSuccessAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: LocaleKeys.welcomeAboard.value,
          message: LocaleKeys.accountCreatedSuccessMessage.value,
          primaryButtonTitle: LocaleKeys.verifyKycNow.value,
          onPrimaryButtonPressed: () {},
          secondaryButtonTitle: LocaleKeys.skipIWillDoItLater.value,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const MyAppBar(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.inset,
          vertical: AppSize.viewMargin,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              title: LocaleKeys.setupNow.value,
              buttonType: ButtonType.round,
              onPressed: () {
                _showRegisterSuccessAlertDialog(context);
              },
            ),
            const SizedBox(height: AppSize.inset),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                LocaleKeys.skipIWillDoItLater.value,
                style: theme.textTheme.titleMedium?.copyWith(
                  decoration: TextDecoration.underline,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: const SetBiometricsBody(),
    );
  }
}

class SetBiometricsBody extends StatefulWidget {
  const SetBiometricsBody({super.key});

  @override
  State<SetBiometricsBody> createState() => _SetBiometricsBodyState();
}

class _SetBiometricsBodyState extends State<SetBiometricsBody> {
  var formKey = GlobalKey<FormState>();
  String code = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: AppSize.viewMargin,
        horizontal: AppSize.inset,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: AppSize.inset,
                bottom: AppSize.spacedViewSpacing * 3,
              ),
              child: Text(
                LocaleKeys.setupBiometricsNow.value,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 36),
              ),
            ),
            Center(
              child: CircleAvatar(
                radius: AppSize.inset * 4,
                backgroundColor: theme.disabledColor.withOpacity(0.2),
                child: SvgPicture.asset(AppSvg.biometrics, height: AppSize.inset * 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
