import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/operator_history_bloc.dart';
import 'operator_history_view.dart';

class OperatorHistoryPage extends StatefulWidget {
  const OperatorHistoryPage({super.key});

  @override
  State<OperatorHistoryPage> createState() => OperatorHistoryPageState();
}

class OperatorHistoryPageState extends State<OperatorHistoryPage> {
  @override
  void initState() {
    super.initState();
    // context.read<OperatorHistoryBloc>().add(GetOrderHistory(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.orderHistoryTitle.value),
      body: const OperatorHistoryView(),
    );
  }
}
