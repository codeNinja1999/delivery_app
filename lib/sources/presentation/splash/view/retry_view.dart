import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/splash_bloc.dart';

class BasicRetryView extends StatelessWidget {
  const BasicRetryView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppSize.viewSpacing,
            horizontal: AppSize.viewMargin,
          ),
          child: Column(
            children: [
              Text(LocaleKeys.unexpectedError.value,
                  style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
              Padding(
                padding: const EdgeInsets.only(top: AppSize.inset),
                child: Text(LocaleKeys.unexpectedErrorDesc.value,
                    style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSize.inset),
                child: CustomButton(
                  title: LocaleKeys.tryAgain.value,
                  onPressed: () {
                    context.read<SplashBloc>().add(GenerateKey());
                  },
                  buttonType: ButtonType.round,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
