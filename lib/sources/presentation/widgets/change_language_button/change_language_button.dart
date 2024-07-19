import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class ChangeLanguageButton extends StatelessWidget {
  final VoidCallback onChangeLanguage;
  final String selectedLanguage;
  const ChangeLanguageButton({
    super.key,
    required this.onChangeLanguage,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.viewSpacing),
      onTap: () {
        onChangeLanguage();
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.tertiary),
          borderRadius: BorderRadius.circular(AppSize.cornerRadius * 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: AppSize.inset * 0.25),
            SvgPicture.asset(
              AppSvg.languageSvg,
              height: AppSize.iconHeight,
            ),
            const SizedBox(width: AppSize.inset * 0.35),
            Text(
              selectedLanguage,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(width: AppSize.inset * 0.30),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: AppSize.iconHeight * 1.25,
              fill: 1,
              color: theme.textTheme.titleSmall?.color,
            ),
            const SizedBox(width: AppSize.inset * 0.125),
          ],
        ),
      ),
    );
  }
}
