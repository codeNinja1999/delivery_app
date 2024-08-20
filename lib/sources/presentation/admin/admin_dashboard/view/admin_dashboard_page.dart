import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

import 'admin_dashboard_view.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<AdminDashboardPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: const MyAppBar(
          allowBack: false,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppSize.viewMargin),
              child: Row(
                children: [
                  NotificationBadge(),
                  SizedBox(width: AppSize.inset),
                  CircleAvatar(
                    child: Text("FD"),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: const AdminDashboardView(),
      ),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
        child: Icon(
          Icons.notifications,
          color: AppColors.backgroundContainerLight,
        ),
      ),
    );
  }
}
