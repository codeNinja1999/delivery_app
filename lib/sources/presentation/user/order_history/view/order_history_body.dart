import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
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
    // _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // User has reached the end of the list
      // Load more data or trigger pagination in flutter
      final mainBloc = context.read<OrderHistoryBloc>();
      if (!mainBloc.state.paginationEnd) {
        mainBloc.add(GetTransactionList(mainBloc.state.pageNumber + 1, false));
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
          Navigator.pushNamed(context, AppRoute.transactionDetail, arguments: state.transactionId);
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
    return
       RefreshIndicator(
        onRefresh: () async {},
        child: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          buildWhen: (previous, current) =>
              previous.status != current.status || previous.paginationStatus != current.paginationStatus,
          builder: (context, state) {
            // if (state.status is InProgress) {
            // return Skeleton.fromColors(
            //   baseColor: theme.highlightColor.withOpacity(0.3),
            //   highlightColor: theme.highlightColor.withOpacity(0.1),
            //   enabled: true,
            //   child: ListView.builder(
            //     padding: EdgeInsets.zero,
            //     itemCount: 5,
            //     itemBuilder: (context, index) => const RecentOrderHistoryListView(),
            //   ),
            // );
            // // } else {
            // //   if (state.transactionList.isNotEmpty) {
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
                        // final menuItem = state.transactionList[index];
                        // return menuItem.itemType == RemittanceMenuItemType.heading
                        //     ? RecentTransactionHeaderView(title: menuItem.date)
                        //     :
                        return const RecentOrderHistoryListView(
                            // data: state.transactionList[index],
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
            //   } else {
            //     return SingleChildScrollView(
            //       physics: const AlwaysScrollableScrollPhysics(),
            //       child: Container(
            //         height: MediaQuery.of(context).size.height * 0.6,
            //         alignment: Alignment.center,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Image.asset(
            //               AppImages.noBeneficiary,
            //               height: AppSize.viewSpacing * 6,
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(top: AppSize.inset, bottom: AppSize.inset),
            //               child: Text(
            //                 LocaleKeys.noTransactionCreatedYet.value,
            //                 style: theme.textTheme.bodyLarge,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   }
            // }
          },
        ),

    );
  }
}
