import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class FraudDetails extends StatelessWidget {
  const FraudDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.fraudInformation.value),
      body: Padding(
          padding: const EdgeInsets.all(AppSize.viewMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.pleaseBeAwareOfScam.value,
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 20),
              ),
              const SizedBox(height: AppSize.inset),
              Text(
                LocaleKeys.fraudInformationTitle.value,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: AppSize.inset),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  const Text("• "),
                  Expanded(
                    child: Text(
                      LocaleKeys.fraudInformationOne.value,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.inset),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  const Text("• "),
                  Expanded(
                    child: Text(
                      LocaleKeys.fraudInformationTwo.value,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.inset),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  const Text("• "),
                  Expanded(
                    child: Text(
                      LocaleKeys.fraudInformationThree.value,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
