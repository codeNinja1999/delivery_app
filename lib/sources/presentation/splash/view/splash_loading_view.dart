import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class SplashLoadingView extends StatelessWidget {
  const SplashLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          AppImages.logo,
          fit: BoxFit.scaleDown,
          width: MediaQuery.of(context).size.width * 0.7,
        ),
        // GradientText(
        //   LocaleKeys.appName.value,
        //   style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 42),
        //   gradient: LinearGradient(colors: [
        //     AppColors.primary,
        //     AppColors.primary,
        //   ]),
        // ),
        // const SizedBox(height: AppSize.spacedViewSpacing),
        // CupertinoActivityIndicator(color: Theme.of(context).colorScheme.primary)
      ]),
    );
  }
}
