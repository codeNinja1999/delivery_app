import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/order_history_bloc.dart';
import 'order_history_body.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => OrderHistoryPageState();
}

class OrderHistoryPageState extends State<OrderHistoryPage> {
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
      body: const OrderHistoryBody(),
    );
  }
}
