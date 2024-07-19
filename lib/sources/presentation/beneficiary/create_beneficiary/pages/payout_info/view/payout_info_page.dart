import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'payout_info_form.dart';

class PayoutInfoPage extends StatefulWidget {
  const PayoutInfoPage({super.key});

  @override
  State<PayoutInfoPage> createState() => _PayoutInfoPageState();
}

class _PayoutInfoPageState extends State<PayoutInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(
        title: LocaleKeys.beneficiaryTitle.value,
        backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
      body: const PayoutInfoForm(),
    );
  }
}
