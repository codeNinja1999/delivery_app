import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class KycNoticeView extends StatelessWidget {
  const KycNoticeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        border: Border.all(color: theme.colorScheme.tertiary, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(3.0)),
      ),
      padding: const EdgeInsets.all(AppSize.viewMargin),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: LocaleKeys.pleaseVerifyYourKyc.value,
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: " ${LocaleKeys.tapHere.value} ",
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.of(context).pushNamed(
                      AppRoute.idVerification,
                    ),
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
            ),
            TextSpan(
              text: LocaleKeys.toVerifyKyc.value,
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
