import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

import '../bloc/notification_list_bloc.dart';

class NotificationListPage extends StatefulWidget {
  const NotificationListPage({super.key});

  @override
  State<NotificationListPage> createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<NotificationListBloc>().add(GetNotificationList());
  // }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AppPage(
      appBar: MyAppBar(title: LocaleKeys.notifications.value),
      body: Padding(
        padding: EdgeInsets.only(
          left: context.hInset,
          right: context.hInsetR,
          bottom: AppSize.bottomSafeInset,
        ),
        child: BlocListener<NotificationListBloc, NotificationListState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            final status = state.status;
            if (status is SubmissionFailure) {
              ErrorResolver.resolve(context, status);
            }
          },
          child: RefreshIndicator(
            onRefresh: () async {},
            // context.read<NotificationListBloc>().add(GetNotificationList()),
            child: BlocBuilder<NotificationListBloc, NotificationListState>(
              builder: (context, state) {
                // if (state.status is InProgress) {
                //   return Skeleton.fromColors(
                //     baseColor: theme.highlightColor.withOpacity(0.3),
                //     highlightColor: theme.highlightColor.withOpacity(0.1),
                //     enabled: true,
                //     child: ListView.builder(
                //       padding: EdgeInsets.zero,
                //       itemCount: 10,
                //       itemBuilder: (context, index) {
                //         return const RecentNotificationListView();
                //       },
                //     ),
                //   );
                // } else {

                return SizedBox.expand(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.noNotification),
                        const SizedBox(height: AppSize.inset),
                        Text("No Notifications yet", style: theme.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                );
                // return ListView.separated(
                //   padding: const EdgeInsets.symmetric(vertical: AppSize.inset),
                //   separatorBuilder: (context, index) => Divider(color: theme.disabledColor),
                //   itemCount: state.notificationList.length,
                //   itemBuilder: ((context, index) {
                //     return RecentNotificationListView(data: state.notificationList[index]);
                //   }),
                // );
                // }
              },
            ),
          ),
        ),
      ),
    );
  }
}
