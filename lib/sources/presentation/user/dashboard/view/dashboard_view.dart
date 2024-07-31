import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../history/history.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/shortcut_action_view.dart';

String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  if (hour < 12) {
    return LocaleKeys.goodMorning.value;
  } else if (hour < 18) {
    return LocaleKeys.goodAfternoon.value;
  } else {
    return LocaleKeys.goodEvening.value;
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSize.viewMargin),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${getGreeting()} ${LocaleKeys.appName.value}", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: AppSize.viewSpacing),
            Text("Get your laundry done with Freshfold delivery", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSize.viewSpacing),
            Text(
              'What do you want to do today?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSize.inset),
            const ShortcutActionView(),
            const PendingTransactionList(),
          ]),
        ),
      ),
    );
  }
}

class PendingTransactionList extends StatelessWidget {
  const PendingTransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) => previous.pendingList != current.pendingList,
      builder: (context, state) {
        return (state.pendingList.isNotEmpty)
            ? Padding(
                padding: const EdgeInsets.only(top: AppSize.inset),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: AppSize.inset, top: AppSize.viewSpacing * 1.5),
                      child: Text(
                        LocaleKeys.pendingTransaction.value,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: AppSize.viewSpacing,
                            ),
                      ),
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.pendingList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return RecentOrderHistoryListView(
                          data: state.pendingList[index],
                          onTap: () => (state.pendingList[index].transactionId != null)
                              ? Navigator.pushNamed(
                                  context,
                                  AppRoute.transactionDetail,
                                  arguments: state.pendingList[index].transactionId,
                                )
                              : null,
                        );
                      },
                    ),
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
