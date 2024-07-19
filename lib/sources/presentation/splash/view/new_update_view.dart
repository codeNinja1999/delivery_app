import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';
import '../bloc/splash_bloc.dart';

class NewUpdateView extends StatelessWidget {
  const NewUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: AnnotatedRegion(
        value: overlay,
        child: Padding(
          padding: const EdgeInsets.only(left: AppSize.viewMargin, right: AppSize.viewMargin),
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              final status = state.status as UpdateAvailable;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 0,
                      left: AppSize.spacedViewSpacing,
                      right: AppSize.spacedViewSpacing,
                    ),
                    child: SvgPicture.asset(
                      AppSvg.newUpdate,
                      width: AppSize.screenWidth * 0.7,
                      height: AppSize.screenWidth * 0.7,
                    ),
                  ),
                  const SizedBox(height: AppSize.inset),
                  Text(
                    "New Version!",
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSize.inset),
                  Text(status.message, style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
                  const SizedBox(height: AppSize.viewSpacing),
                  CustomButton(
                    buttonType: ButtonType.round,
                    title: LocaleKeys.update.value,
                    onPressed: () {
                      final appId = Platform.isAndroid ? 'com.iremitx.light.remit' : '6448636208';
                      final url = Uri.parse(
                        Platform.isAndroid ? "market://details?id=$appId" : "https://apps.apple.com/app/id$appId",
                      );
                      launchUrl(url, mode: LaunchMode.externalApplication);
                    },
                  ),
                  const SizedBox(height: AppSize.inset * 0.5),
                  if (!status.needForceUpdate)
                    CustomButton(
                      buttonType: ButtonType.round,
                      title: "Not now",
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.starting);
                      },
                      backgroundColor: Colors.transparent,
                    )
                  // foregroundColor: theme.textTheme.bodyMedium?.color)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
