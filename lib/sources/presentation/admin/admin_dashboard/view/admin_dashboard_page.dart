import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import 'package:fresh_fold_delivery/sources/presentation/user/dashboard/widgets/widgets.dart';
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
    return PopScope(
      canPop: true,
      child: Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          backgroundColor: AppColors.backgroundDark,
          appBar: const MyAppBar(
            allowBack: false,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: AppSize.viewMargin),
                child: Row(
                  children: [
                    NotificationBadge(),
                    SizedBox(width: AppSize.inset),
                    CircleAvatar(child: Text("FD")),
                  ],
                ),
              ),
            ],
          ),
          body: const AdminDashboardView(),
        ),
      ),
    );
  }
}
