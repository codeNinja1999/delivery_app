import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../widgets/notification_badge.dart';
import 'operator_dashboard_view.dart';

class OperatorDashboardPage extends StatefulWidget {
  const OperatorDashboardPage({super.key});

  @override
  State<OperatorDashboardPage> createState() => _OperatorDashboardPageState();
}

class _OperatorDashboardPageState extends State<OperatorDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: SafeArea(
        child: AnnotatedRegion(
          value: overlay,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: const MyAppBar(
              allowBack: false,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: AppSize.viewMargin),
                  child: NotificationBadge(),
                ),
              ],
            ),
            body: const OperatorDashboardView(),
          ),
        ),
      ),
    );
  }
}
