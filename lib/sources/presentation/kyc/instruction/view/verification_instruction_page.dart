import 'package:flutter/material.dart';

import '../../../../core/app_core.dart';
import '../../../../resources/resources.dart';
import '../../../widgets/widgets.dart';
import '../../route/kyc_verification_route.dart';

class VerificationInstructionPage extends StatefulWidget {
  const VerificationInstructionPage({super.key});

  @override
  State<VerificationInstructionPage> createState() => _VerificationInstructionPageState();
}

class _VerificationInstructionPageState extends State<VerificationInstructionPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(
        title: LocaleKeys.kycVerification.value,
        backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.viewMargin,
          vertical: AppSize.viewSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(AppImages.kyc, height: MediaQuery.of(context).size.height * 0.23)),
            const SizedBox(height: AppSize.inset),
            Text(
              LocaleKeys.letsVerifyKyc.value,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSize.inset),
            Text(
              LocaleKeys.pleaseReadyYourDocumentToVerifyKyc.value,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: AppSize.viewMargin),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(right: AppSize.cornerRadiusMedium),
                child: Icon(Icons.contact_emergency),
              ),
              title: Text(
                LocaleKeys.governmentIssuedId.value,
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                LocaleKeys.cardInstruction.value,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: AppSize.inset),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.only(right: AppSize.cornerRadiusMedium),
                child: Icon(Icons.contact_emergency),
              ),
              title: Text(
                LocaleKeys.takeASelfieWithId.value,
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                LocaleKeys.selfieInstruction.value,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: AppSize.spacedViewSpacing),
            CustomButton(
              title: LocaleKeys.getStarted.value,
              onPressed: () {
                Navigator.pushNamed(context, KycVerificationRoute.personalInformation);
              },
            )
          ],
        ),
      ),
    );
  }
}
