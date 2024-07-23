import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   elevation: 0,
        //   actions: [
        //     BlocBuilder<PromotionBloc, PromotionState>(
        //       buildWhen: (previous, current) => previous.changeLanguage != current.changeLanguage,
        //       builder: (context, state) {
        //         return ChangeLanguageButton(
        //           onChangeLanguage: () => Navigator.pushNamed(context, AppRoute.changeLanguage),
        //           selectedLanguage: StringUtils.getCountryName(context.locale.countryCode ?? ""),
        //         );
        //       },
        //     ),
        //     const SizedBox(width: AppSize.inset),
        //   ],
        // ),
        body: Stack(
          children: [
            Image.asset(AppImages.promotionBackground, opacity: AnimationController(vsync: this, value: .9)),
            Padding(
              padding: const EdgeInsets.all(
                AppSize.viewMargin,
              ),
              child: Column(
                children: [
                  // const PromotionSliderView(),
                  const Spacer(),
                  Text(
                    "Laundry Made Easy",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: AppSize.inset * 2,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Text(
                    "One stop for all your laundry",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const SizedBox(height: AppSize.spacedViewSpacing),

                  CustomButton(
                    title: LocaleKeys.logIn.value,
                    onPressed: () {
                      // context.read<PromotionBloc>().add(SetAppLaunchStatus());
                      Navigator.of(context).pushNamed(AppRoute.login);
                    },
                  ),
                  const SizedBox(height: AppSize.inset),

                  CustomButton(
                    buttonType: ButtonType.bordered,
                    title: LocaleKeys.register.value,
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.white,
                    titleColor: Colors.white,
                    onPressed: () {
                      // context.read<PromotionBloc>().add(SetAppLaunchStatus());
                      Navigator.of(context).pushNamed(AppRoute.newMemberPage);
                    },
                  ),
                  const SizedBox(height: AppSize.inset),

                  TextButton(
                    onPressed: () {
                      // context.read<PromotionBloc>().add(SetAppLaunchStatus());
                      // Navigator.of(context).pushNamed(AppRoute.newMemberPage);
                    },
                    child: Text(LocaleKeys.continueAsGuest.value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
