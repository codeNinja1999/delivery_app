import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../bloc/account_bloc.dart';
import 'account_menu_list_view.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    context.read<AccountBloc>().add(AccountInfoSubscriptionRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: LocaleKeys.accountTitle.value,
        backButtonAction: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const AccountMenuListView(),
    );
  }
}
