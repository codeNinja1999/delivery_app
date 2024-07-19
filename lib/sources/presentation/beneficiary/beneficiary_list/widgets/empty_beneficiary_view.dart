import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/beneficiary_list_bloc.dart';

class EmptyBeneficiaryView extends StatelessWidget {
  const EmptyBeneficiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: () async => context.read<BeneficiaryListBloc>().add(GetBeneficiaryList()),
      child: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                AppImages.noBeneficiary,
                height: AppSize.viewSpacing * 6,
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppSize.inset, bottom: AppSize.inset),
                child: Text(
                  LocaleKeys.noBeneficiaryAdded.value,
                  style: theme.textTheme.titleMedium?.copyWith(fontSize: 20),
                ),
              ),
              Text(
                LocaleKeys.pleaseAddABeneficiaryToSendTransaction.value,
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.viewSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin),
                child: CustomButton(
                  title: LocaleKeys.addNewBeneficiary.value,
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoute.createBeneficiary);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
