import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.bottomSheetTheme.backgroundColor,
      appBar: MyAppBar(
        title: LocaleKeys.contactUs.value,
        backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
        backgroundColor: theme.bottomSheetTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppSize.viewMargin,
          right: AppSize.viewMargin,
          top: AppSize.spacedViewSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Inception Technology Company Limited (Head Office)"),
            const SizedBox(height: 5),
            const Text("1758/4 Sukhumvit Road, Phra Khanong Tai, Phra Khanong Bangkok 10260"),
            const SizedBox(height: 5),
            const Text("Call 02-003-4092"),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(LocaleKeys.emailTitle.value),
                const SizedBox(width: AppSize.inset * 0.4),
                const Text(
                  "support@inception.asia",
                  style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: AppSize.viewSpacing),
              child: Text(
                  "Authorized Money Transfer Agent License no. MT125650097 issued by Bank of Thailand and The Ministry of Finance"),
            ),
            const Spacer(),
            const SupportView(),
          ],
        ),
      ),
    );
  }
}
