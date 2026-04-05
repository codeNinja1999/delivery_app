import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../../../../resources/resources.dart';
import '../../../widgets/widgets.dart';
import '../bloc/admin_dashboard_bloc.dart';
import '../widgets/home_view.dart';
import '../widgets/location_view.dart';
import '../widgets/operator_view.dart';
import '../widgets/price_view.dart';
import '../widgets/sales_view.dart';
import '../widgets/user_view.dart';

String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  if (hour < 12) {
    return LocaleKeys.goodMorning.value;
  } else if (hour < 18) {
    return LocaleKeys.goodAfternoon.value;
  } else {
    return LocaleKeys.goodEvening.value;
  }
}

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  int selectedIndex = 0;

  final list = ["Home", "User", "Operator", "Location", "Sales", "Pricing"];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AdminDashboardBloc, AdminDashboardState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: RefreshIndicator(
        backgroundColor: Colors.white,
        onRefresh: () async {
          context.read<AdminDashboardBloc>().add(GetDashboardData());
        },
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSize.viewMargin),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${getGreeting()} ${LocaleKeys.appName.value}", style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: AppSize.viewSpacing),
              Text("Admin", style: Theme.of(context).textTheme.titleLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(""),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: Text(
                        "Filter",
                        style: theme.textTheme.bodyMedium,
                      ),
                      side: BorderSide(color: AppColors.primary),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.inset)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.inset),
              BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.all(AppSize.inset * 0.75),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Analytics",
                                style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Today",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700, color: HexColor("#9F9F9F")),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: AppSize.inset),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Total active request",
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                state.analyticsInfo?.totalActiveRequests ?? "",
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: AppSize.inset),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Total user",
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                state.analyticsInfo?.totalUser ?? "",
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: AppSize.inset),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Total operator",
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                state.analyticsInfo?.totalOperator ?? "",
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: AppSize.inset),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Sales Summary",
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "\$${state.analyticsInfo?.totalActiveRequests ?? ""}",
                                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSize.inset),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Chip(
                        label: Text(list[index]),
                        side: BorderSide(color: theme.colorScheme.shadow),
                        labelStyle: TextStyle(
                          color:
                              selectedIndex == index ? Theme.of(context).scaffoldBackgroundColor : AppColors.darkTextColor,
                        ),
                        backgroundColor: selectedIndex == index ? AppColors.primary : theme.colorScheme.shadow,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.inset),
              if (selectedIndex == 0) ...[
                const HomeView(),
              ],
              if (selectedIndex == 1) ...[
                const UserView(),
              ],
              if (selectedIndex == 2) ...[
                const OperatorView(),
              ],
              if (selectedIndex == 3) ...[
                const LocationView(),
              ],
              if (selectedIndex == 4) ...[
                const SalesView(),
              ],
              if (selectedIndex == 5) ...[
                const PriceView(),
              ]
            ]),
          );
        }),
      ),
    );
  }
}
