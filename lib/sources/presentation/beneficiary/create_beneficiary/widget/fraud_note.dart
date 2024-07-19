import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import '../route/beneficiary_route.dart';

class FraudNotes extends StatelessWidget {
  const FraudNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, BeneficiaryRoute.fraudDetail),
      child: Card(
        color: theme.colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.inset * 0.75),
          side: BorderSide(color: theme.colorScheme.tertiary),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSize.inset, vertical: AppSize.cornerRadiusSmall),
          minLeadingWidth: 0,
          leading: Padding(
            padding: const EdgeInsets.only(bottom: AppSize.inset),
            child: SvgPicture.asset(
              AppSvg.information,
              height: AppSize.viewSpacing,
            ),
          ),
          dense: true,
          title: Text(
            "Take a moment to stop fraud",
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            "Learn More",
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
