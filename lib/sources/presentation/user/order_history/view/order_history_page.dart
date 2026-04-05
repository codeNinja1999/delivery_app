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
    context.read<OrderHistoryBloc>().add(GetOrderHistory(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: MyAppBar(title: LocaleKeys.orderHistoryTitle.value),
      body: const OrderHistoryBody(),
    );
  }
}
