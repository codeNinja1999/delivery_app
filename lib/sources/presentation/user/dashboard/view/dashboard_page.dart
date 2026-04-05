import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/core/helper/helper.dart';
import 'package:fresh_fold_delivery/sources/presentation/user/dashboard/dashboard.dart';

import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../route/user_route.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // final bloc = context.read<DashboardBloc>();
    // bloc.add(GetDashboardData());
    // bloc.add(UserInfoSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // canPop: false,
      // onPopInvokedWithResult: (didPop, result) async {
      //   if (didPop) return; // ← already popped, skip

      //   await AppExitHelper.handleBackPress(context);
      // },
      child: AppPage(
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
                    onTap: () => Navigator.of(context).pushNamed(UserRoute.profile),
                    child: const CircleAvatar(child: Text("P")),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: context.hInset,
            right: context.hInsetR,
            bottom: AppSize.bottomSafeInset,
          ),
          child: const DashboardView(),
        ),
      ),
    );
  }
}
