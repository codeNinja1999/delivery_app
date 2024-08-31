import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import 'package:fresh_fold_delivery/sources/presentation/user/dashboard/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../route/user_route.dart';
import 'dashboard_view.dart';

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
    // bloc.add(TransactionListSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    // SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness:
    //       PlatformDispatcher.instance.platformBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
    //   statusBarBrightness:
    //       PlatformDispatcher.instance.platformBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
    // );
    return PopScope(
      canPop: true,
      child: SafeArea(
        child: AnnotatedRegion(
          value: overlay,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
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
            body: const DashboardView(),
          ),
        ),
      ),
    );
  }
}
