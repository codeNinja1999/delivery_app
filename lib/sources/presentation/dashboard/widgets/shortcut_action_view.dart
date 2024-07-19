import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class ShortcutActionView extends StatelessWidget {
  const ShortcutActionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoute.sendMoney);
            },
            style: TextButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              padding: const EdgeInsets.symmetric(
                vertical: AppSize.inset * 0.9,
                horizontal: AppSize.viewSpacing * 1.25,
              ),
            ),
            icon: SvgPicture.asset(AppSvg.arrowOutwardRight, height: AppSize.iconHeight * 0.5),
            label: Text(
              LocaleKeys.send.value,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: AppSize.inset * 0.75),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.checkRate);
            },
            style: TextButton.styleFrom(
              backgroundColor: theme.colorScheme.surface,
              padding: const EdgeInsets.symmetric(vertical: AppSize.inset * 0.9, horizontal: AppSize.viewSpacing * 1.25),
              side: BorderSide(color: theme.colorScheme.primary),
            ),
            child: Text(
              LocaleKeys.checkRate.value,
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
