import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/deposit_bank_bloc.dart';
import 'deposit_bank_body.dart';

class DepositBankPage extends StatefulWidget {
  const DepositBankPage({super.key});

  @override
  State<DepositBankPage> createState() => _DepositBankPageState();
}

class _DepositBankPageState extends State<DepositBankPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<DepositBankBloc>();
    bloc.add(GetDepositType());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(
        title: LocaleKeys.uploadReceiptTitle.value,
        backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
      body: const DepositBankBody(),
    );
  }
}
