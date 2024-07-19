import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Image.asset(
                AppImages.logo,
                fit: BoxFit.scaleDown,
                width: MediaQuery.of(context).size.width * 0.13,
              ),
              Text(
                "Akbar",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ]),
            const Text(""),
            ChangeLanguageButton(
              onChangeLanguage: () => Navigator.pushNamed(context, AppRoute.changeLanguage),
              selectedLanguage: StringUtils.getCountryName(
                context.locale.countryCode ?? "",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
