import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/order_history_bloc.dart';

class RecentTransactionHeaderView extends StatefulWidget {
  const RecentTransactionHeaderView({super.key, this.title});

  final String? title;

  @override
  State<RecentTransactionHeaderView> createState() => _RecentTransactionHeaderViewState();
}

class _RecentTransactionHeaderViewState extends State<RecentTransactionHeaderView> {
  String _getDateCategory(String date) {
    final DateTime currentDate = DateTime.now();
    final DateTime transactionDate = DateTime.parse(date);

    if (transactionDate.isAtSameMomentAs(currentDate)) {
      return 'Today';
    } else if (transactionDate.isAfter(currentDate) && transactionDate.isBefore(currentDate.add(const Duration(days: 1)))) {
      return 'Tomorrow';
    } else if (transactionDate.isAfter(currentDate.add(const Duration(days: 1)))) {
      return 'Next Day';
    } else {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String dateCategory = _getDateCategory(widget.title ?? "Today");
    return BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.inset),
          child: Text(
            dateCategory,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
