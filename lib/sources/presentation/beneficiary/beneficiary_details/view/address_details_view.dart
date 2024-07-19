import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/beneficiary_detail_bloc.dart';
import 'beneficiary_detail_view.dart';

class AddressDetailsView extends StatelessWidget {
  const AddressDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<BeneficiaryDetailBloc, BeneficiaryDetailState>(
      builder: (context, state) {
        final receiver = state.receiver;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(top: AppSize.spacedViewSpacing * 0.67),
              child: Text(
                LocaleKeys.addressDetailTitle.value.toUpperCase(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  letterSpacing: 2.2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSize.inset, bottom: AppSize.inset * 0.5),
              child: Divider(height: 0, indent: 0, thickness: 1, color: theme.dividerColor),
            ),
            ListItemViewDetail(title: LocaleKeys.country.value, value: receiver?.countryName),
            if (receiver?.state?.value != "")
              ListItemViewDetail(title: LocaleKeys.state.value, value: receiver?.state?.value ?? "-"),
            if (receiver?.city?.value != "")
              ListItemViewDetail(title: LocaleKeys.cityLabel.value, value: receiver?.city?.value ?? "-"),
            if (receiver?.address != "") ListItemViewDetail(title: LocaleKeys.addressLabel.value, value: receiver?.address),
            if (receiver?.zipCode != "") ListItemViewDetail(title: LocaleKeys.zipCodeLabel.value, value: receiver?.zipCode),
          ],
        );
      },
    );
  }
}
