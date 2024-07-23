import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/order_history_bloc.dart';
import 'filter_transaction_type.dart';

class HistoryTypeSelection extends StatefulWidget {
  const HistoryTypeSelection({super.key});

  @override
  State<HistoryTypeSelection> createState() => _HistoryTypeSelectionState();
}

class _HistoryTypeSelectionState extends State<HistoryTypeSelection> {
  List<Filter> filterList = [
    Filter(1, LocaleKeys.allTransactions.value),
    Filter(3, LocaleKeys.remittance.value),
  ];

  int sIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.cornerRadiusMedium * 7,
      padding: const EdgeInsets.only(top: AppSize.inset, left: AppSize.inset),
      child: BlocBuilder<TransactionListBloc, TransactionListState>(
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: filterList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FilterTransactionType(
                currentIndex: index,
                selectedIndex: sIndex,
                onTap: () {
                  setState(() {
                    sIndex = index;
                    context.read<TransactionListBloc>().add(GetTransactionList(state.pageNumber, false));
                  });
                },
                title: filterList[index].filterType,
                // title: "All Transaction",
              );
            },
          );
        },
      ),
    );
  }
}

class Filter {
  final int id;
  final String filterType;

  Filter(this.id, this.filterType);
}
