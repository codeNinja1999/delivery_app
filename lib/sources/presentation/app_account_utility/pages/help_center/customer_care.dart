import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../route/app_account_utility_route.dart';

class CustomerCarePage extends StatefulWidget {
  const CustomerCarePage({super.key});

  @override
  State<CustomerCarePage> createState() => _CustomerCarePageState();
}

class _CustomerCarePageState extends State<CustomerCarePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: LocaleKeys.customerCareTitle.value,
        backButtonAction: () {
          final navigator = Navigator.of(context);
          if (navigator.widget.initialRoute == AppAccountUtilityRoute.customerCare) {
            Navigator.of(context, rootNavigator: true).pop();
          } else {
            navigator.pop();
          }
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const CustomerCareBody(),
    );
  }
}

class CustomerCareBody extends StatelessWidget {
  const CustomerCareBody({super.key});

  Future<void> _sendEmail(String emailAddress) async {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: emailAddress, queryParameters: {'subject': '', 'body': ''});
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      print('Could not launch email');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.inset,
        vertical: AppSize.viewMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppSvg.email,
                height: AppSize.viewSpacing,
                width: AppSize.viewSpacing,
                colorFilter: ColorFilter.mode(theme.colorScheme.primary, BlendMode.srcIn),
              ),
              const SizedBox(width: AppSize.cornerRadiusMedium),
              Text(LocaleKeys.emailTitle.value, style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: AppSize.viewSpacing),
          InkWell(
            onTap: () => _sendEmail(AppConstants.email1),
            overlayColor: WidgetStateProperty.all(theme.colorScheme.shadow),
            child: Text(
              AppConstants.email1,
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary),
            ),
          ),
          const SizedBox(height: AppSize.inset),
          InkWell(
            onTap: () => _sendEmail(AppConstants.email2),
            overlayColor: WidgetStateProperty.all(theme.colorScheme.shadow),
            child: Text(
              AppConstants.email2,
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
            child: Divider(color: theme.dividerColor.withOpacity(0.1)),
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppSvg.phone,
                width: AppSize.viewSpacing,
                height: AppSize.viewSpacing,
                colorFilter: ColorFilter.mode(theme.colorScheme.primary, BlendMode.srcIn),
              ),
              const SizedBox(width: AppSize.cornerRadiusMedium),
              Text(LocaleKeys.phoneNumberTitle.value, style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: AppSize.viewSpacing),
          InkWell(
            onTap: () => _makePhoneCall(AppConstants.phone1),
            overlayColor: WidgetStateProperty.all(theme.colorScheme.shadow),
            child: Text(AppConstants.phone1, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary)),
          ),
          const SizedBox(height: AppSize.inset),
          InkWell(
            onTap: () => _makePhoneCall(AppConstants.phone2),
            overlayColor: WidgetStateProperty.all(theme.colorScheme.shadow),
            child: Text(AppConstants.phone2, style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}
