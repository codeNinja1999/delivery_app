import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/dashboard/widgets/widgets.dart';
import '../bloc/dashboard_bloc.dart';
import 'dashboard_view.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.sendMoneyCallBack});
  final VoidCallback sendMoneyCallBack;

  @override
  State<DashboardPage> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<DashboardBloc>();
    bloc.add(GetDashboardData());
    bloc.add(UserInfoSubscriptionRequested());
    bloc.add(TransactionListSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          PlatformDispatcher.instance.platformBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
      statusBarBrightness:
          PlatformDispatcher.instance.platformBrightness == Brightness.dark ? Brightness.light : Brightness.dark,
    );
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: RefreshIndicator(
            onRefresh: () async => context.read<DashboardBloc>().add(GetDashboardData()),
            child: const CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
                CustomDynamicSliverAppBar(
                  toolbarHeight: AppSize.buttonHeight * 4,
                  flexibleSpace: ProfileView(),
                  automaticallyImplyLeading: false,
                ),
                SliverToBoxAdapter(child: DashboardView()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
