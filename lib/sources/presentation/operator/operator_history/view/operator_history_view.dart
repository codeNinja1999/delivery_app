import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../bloc/operator_history_bloc.dart';
import 'recent_transaction_list_view.dart';

class OperatorHistoryView extends StatefulWidget {
  const OperatorHistoryView({super.key});

  @override
  State<OperatorHistoryView> createState() => _OperatorHistoryViewState();
}

class _OperatorHistoryViewState extends State<OperatorHistoryView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final mainBloc = context.read<OperatorHistoryBloc>();
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
    return BlocListener<OperatorHistoryBloc, OperatorHistoryState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        if (status is Success) {}
        if (status is SubmissionFailure) {
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
    return RefreshIndicator(
      onRefresh: () async {
        context.read<OperatorHistoryBloc>().add(GetOrderHistory(1));
      },
      child: BlocBuilder<OperatorHistoryBloc, OperatorHistoryState>(
        buildWhen: (previous, current) =>
            previous.status != current.status || previous.paginationStatus != current.paginationStatus,
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
                      padding: EdgeInsets.zero,
                      itemCount: 5,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(height: AppSize.viewMargin),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final pickUpOrder = state.orderList[index];

                        return RecentOrderHistoryListView(
                          data: pickUpOrder,
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
            return SingleChildScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('No order yet'),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
