import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/transaction_list_bloc.dart';
import 'transaction_list_body.dart';

class TransactionListPage extends StatefulWidget {
  const TransactionListPage({super.key});

  @override
  State<TransactionListPage> createState() => TransactionListPageState();
}

class TransactionListPageState extends State<TransactionListPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionListBloc>().add(GetTransactionList(1, false));
    context.read<TransactionListBloc>().add(TransactionListSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.transactionHistoryTitle.value),
      body: const TransactionListBody(),
    );
  }
}
