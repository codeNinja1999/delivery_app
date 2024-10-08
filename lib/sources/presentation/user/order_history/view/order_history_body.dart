import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/order_history_bloc.dart';
import 'recent_transaction_list_view.dart';

class OrderHistoryBody extends StatefulWidget {
  const OrderHistoryBody({super.key});

  @override
  State<OrderHistoryBody> createState() => _OrderHistoryBodyState();
}

class _OrderHistoryBodyState extends State<OrderHistoryBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final mainBloc = context.read<OrderHistoryBloc>();
      if (!mainBloc.state.paginationEnd) {
        mainBloc.add(GetOrderHistory(mainBloc.state.pageNumber + 1));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderHistoryBloc, OrderHistoryState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        if (status is Success) {
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: OrderHistoryListView(scrollController: _scrollController),
    );
  }
}

class OrderHistoryListView extends StatelessWidget {
  const OrderHistoryListView({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OrderHistoryBloc>().add(GetOrderHistory(1));
      },
      child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.paginationStatus != current.paginationStatus ||
            previous.orderList != current.orderList,
        builder: (context, state) {
          if (state.orderList.isNotEmpty) {
            return SizedBox.expand(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(AppSize.viewMargin),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: state.orderList?.length ?? 0,
                      separatorBuilder: (context, index) => const SizedBox(height: AppSize.viewMargin),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final pickUpOrder = state.orderList?[index];

                        return RecentOrderHistoryListView(
                          data: pickUpOrder,
                          // onTap: () {
                          //   context.read<OrderHistoryBloc>().add(
                          //         ValidateTransactionId(state.transactionList[index].transactionId ?? ""),
                          //       );
                          // },
                        );
                      },
                    ),
                    (state.paginationStatus is InProgress) ? const CupertinoActivityIndicator() : Container(),
                    state.paginationEnd
                        ? const Padding(
                            padding: EdgeInsets.only(bottom: AppSize.cornerRadiusMedium),
                            child: Text("No more data available"),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.expand(
              child: Text('No order yet'),
            );
          }
        },
      ),
    );
  }
}
