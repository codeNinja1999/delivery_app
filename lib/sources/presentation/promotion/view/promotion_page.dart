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

class _PromotionPageState extends State<PromotionPage> {
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
            Image.asset(AppImages.promotionBackground),
            Padding(
              padding: const EdgeInsets.all(AppSize.viewMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const PromotionSliderView(),
                  const Spacer(),
                  CustomButton(
                    buttonType: ButtonType.bordered,
                    title: LocaleKeys.createAccount.value,
                    onPressed: () {},
                  ),
                  const SizedBox(height: AppSize.inset),
                  CustomButton(
                    title: LocaleKeys.logIn.value,
                    onPressed: () {
                      // context.read<PromotionBloc>().add(SetAppLaunchStatus());
                      Navigator.of(context).pushNamed(AppRoute.login);
                    },
                  ),
                  CustomButton(
                    title: LocaleKeys.register.value,
                    onPressed: () {
                      // context.read<PromotionBloc>().add(SetAppLaunchStatus());
                      Navigator.of(context).pushNamed(AppRoute.newMemberPage);
                    },
                  ),
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
