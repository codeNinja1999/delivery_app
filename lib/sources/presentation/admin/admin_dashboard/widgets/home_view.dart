import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

import '../../route/admin_route.dart';
import '../bloc/admin_dashboard_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSize.inset),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
        color: theme.colorScheme.surfaceContainer,
      ),
      child: BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
        buildWhen: (previous, current) => previous.orderList != current.orderList,
        builder: (context, state) {
          if (state.orderList == []) {
            return const SizedBox.expand(
              child: Center(child: Text("No Order history")),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pending Confirmation",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AdminRoute.userList);
                        },
                        child: Text(
                          "View All",
                          style: Theme.of(context).textTheme.titleSmall,
                        )),
                  ],
                ),
                const SizedBox(height: AppSize.inset),
                ListView.separated(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(height: AppSize.inset),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(AppSize.inset),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                      ),
                      child: Column(
                        children: [
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Expanded(
                                  child: Text(
                                "John Doe",
                                style: theme.textTheme.titleMedium,
                              )),
                              Expanded(
                                child: Text(
                                  "(989)-223-222",
                                  style: theme.textTheme.titleMedium,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSize.inset),
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Expanded(
                                  child: Text(
                                "Address",
                                style: theme.textTheme.bodySmall,
                              )),
                              Expanded(
                                child: Text(
                                  "Phuket, Ban Tawan, 1415 Unit Near ABC Bus Stand ",
                                  style: theme.textTheme.bodySmall,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSize.inset),
                          Row(
                            textBaseline: TextBaseline.alphabetic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Expanded(
                                  child: Text(
                                "Type",
                                style: theme.textTheme.bodySmall,
                              )),
                              Expanded(
                                child: Text(
                                  "Pickup",
                                  style: theme.textTheme.bodySmall,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSize.inset),
                          CustomButton(backgroundColor: AppColors.primary, title: "View Details", onPressed: () {})
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
