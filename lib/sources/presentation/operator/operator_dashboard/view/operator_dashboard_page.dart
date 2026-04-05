import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../route/operator_route.dart';
import '../bloc/operator_dash_board_bloc.dart';
import '../widgets/notification_badge.dart';
import 'operator_dashboard_view.dart';

class OperatorDashboardPage extends StatefulWidget {
  const OperatorDashboardPage({super.key});

  @override
  State<OperatorDashboardPage> createState() => _OperatorDashboardPageState();
}

class _OperatorDashboardPageState extends State<OperatorDashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<OperatorDashBoardBloc>().add(GetOperatorInfo());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: MyAppBar(
          allowBack: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: AppSize.viewMargin),
              child: Row(
                children: [
                  const NotificationBadge(),
                  const SizedBox(width: AppSize.inset),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(OperatorRoute.operatorProfile),
                    child: const CircleAvatar(child: Text("P")),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: const OperatorDashboardView(),
      ),
    );
  }
}
