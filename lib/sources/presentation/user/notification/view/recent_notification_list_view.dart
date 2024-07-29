import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../model/notification_list_view_model.dart';

class RecentNotificationListView extends StatelessWidget {
  const RecentNotificationListView({super.key, this.data, re});
  final NotificationListViewModel? data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: ThemeData(
        highlightColor: theme.colorScheme.shadow,
        splashColor: theme.colorScheme.shadow,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.inset),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.primary,
            child: Icon(
              Icons.notifications_none_outlined,
              color: theme.colorScheme.surface,
            ),
          ),
          title: Container(
            margin: const EdgeInsets.only(bottom: AppSize.cornerRadiusMedium),
            color: theme.colorScheme.surface,
            child: Text("${data?.msgTitle}", style: theme.textTheme.titleMedium),
          ),
          subtitle: Container(
            color: theme.colorScheme.surface,
            child: Text(
              "${data?.msgBody}",
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          trailing: Container(
            color: theme.colorScheme.surface,
            child: Text(
              "${data?.dateDifference}",
              style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
