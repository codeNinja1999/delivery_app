import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../bloc/splash_bloc.dart';

class MaintenanceView extends StatelessWidget {
  const MaintenanceView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: AppSize.viewMargin, right: AppSize.viewMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppImages.maintenance,
                width: AppSize.screenWidth * 0.7,
                height: AppSize.screenWidth * 0.7,
              ),
              const SizedBox(height: AppSize.viewSpacing),
              Text(
                "Sorry\nUnder Maintenance",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSize.viewSpacing),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: AppSize.spacedViewSpacing),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    buttonType: ButtonType.round,
                    onPressed: () {
                      context.read<SplashBloc>().add(GenerateKey());
                    },
                    title: LocaleKeys.tryAgain.value,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
