import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/beneficiary_detail_bloc.dart';
import 'beneficiary_detail_view.dart';

class AccountDetailsView extends StatelessWidget {
  const AccountDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<BeneficiaryDetailBloc, BeneficiaryDetailState>(
      builder: (context, state) {
        final receiver = state.receiver;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              LocaleKeys.accountDetails.value.toUpperCase(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                letterSpacing: 2.2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSize.inset, bottom: AppSize.inset * 0.5),
              child: Divider(height: 0, indent: 0, thickness: 1, color: theme.dividerColor),
            ),
            ListItemViewDetail(title: LocaleKeys.accountHolderNameLabel.value, value: receiver?.username),
            ListItemViewDetail(title: LocaleKeys.bankName.value, value: receiver?.bank),
            if (receiver?.accountNumber != "")
              ListItemViewDetail(title: LocaleKeys.accountNumber.value, value: receiver?.accountNumber),
            if (receiver?.contactNumber != "")
              ListItemViewDetail(title: LocaleKeys.contactNumber.value, value: receiver?.contactNumber),
            if (receiver?.emailAddress != "")
              ListItemViewDetail(title: LocaleKeys.emailAddressTitle.value, value: receiver?.emailAddress),
            if (receiver?.relationship != "")
              ListItemViewDetail(title: LocaleKeys.relationshipLabel.value, value: receiver?.relationship ?? '-')
          ],
        );
      },
    );
  }
}
