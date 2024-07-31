import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'operator_history_view.dart';

class OperatorHistoryPage extends StatefulWidget {
  const OperatorHistoryPage({super.key});

  @override
  State<OperatorHistoryPage> createState() => OperatorHistoryPageState();
}

class OperatorHistoryPageState extends State<OperatorHistoryPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<TransactionListBloc>().add(GetTransactionList(1, false));
  //   context.read<TransactionListBloc>().add(TransactionListSubscriptionRequested());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.orderHistoryTitle.value),
      body: const OperatorHistoryView(),
    );
  }
}
