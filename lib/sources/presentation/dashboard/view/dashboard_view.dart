import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../history/history.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/shortcut_action_view.dart';
import 'exchange_rate_graph_view.dart';
import 'kyc_notice_view.dart';

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
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const KycStatusWidget(),
          // const BalanceView(),
          const ShortcutActionView(),
          const PendingTransactionList(),
          const SizedBox(height: AppSize.viewSpacing),
          Padding(
            padding: const EdgeInsets.all(AppSize.inset),
            child: Text(
              LocaleKeys.exchangeRate.value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: AppSize.viewSpacing,
                  ),
            ),
          ),
          const ExchangeRateGraphView(),
        ]),
      ),
    );
  }
}

class KycStatusWidget extends StatelessWidget {
  const KycStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) => previous.userInfo != current.userInfo,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSize.viewSpacing),
          child: Visibility(
            visible: state.userInfo?.status != KYCStatus.verified,
            child: state.userInfo?.status == KYCStatus.submitted ? _KycPendingMessageWidget() : const KycNoticeView(),
          ),
        );
      },
    );
  }
}

class _KycPendingMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSize.inset),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        border: Border.all(color: theme.colorScheme.tertiary, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(3.0)),
      ),
      child: Text(
        LocaleKeys.kycPendingMessage.value,
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
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
                        return RecentTransactionListView(
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
