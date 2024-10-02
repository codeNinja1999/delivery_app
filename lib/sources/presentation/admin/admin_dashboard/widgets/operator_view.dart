import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

import '../../route/admin_route.dart';
import '../bloc/admin_dashboard_bloc.dart';

class OperatorView extends StatelessWidget {
  const OperatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSize.inset),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
        color: theme.colorScheme.surfaceContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Operator",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AdminRoute.operatorList);
                },
                child: Text(
                  "View All",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.inset),
          BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
            buildWhen: (previous, current) => previous.operatorList != current.operatorList,
            builder: (context, state) {
              if (state.operatorList == []) {
                return const SizedBox.expand(
                  child: Center(child: Text("No Operator")),
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: (state.operatorList?.length ?? 0) >= 3 ? 3 : state.operatorList?.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(height: AppSize.inset),
                  itemBuilder: (context, index) {
                    final operator = state.operatorList?[index];

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
                                operator?.fullName ?? "",
                                style: theme.textTheme.titleMedium,
                              )),
                              Expanded(
                                child: Text(
                                  operator?.phoneNumber ?? "",
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
                                "Neighbourhood",
                                style: theme.textTheme.bodySmall,
                              )),
                              Expanded(
                                child: Text(
                                  (operator?.neighborhood != null)
                                      ? "${operator?.neighborhood} ${operator?.postalCode ?? ""}"
                                      : "",
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
                          // const SizedBox(height: AppSize.inset),
                          // CustomButton(backgroundColor: AppColors.primary, title: "View Details", onPressed: () {

                          // })
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
          const SizedBox(height: AppSize.viewSpacing),
          CustomButton(backgroundColor: AppColors.primary, title: "Add New Operator", onPressed: () {}),
          const SizedBox(height: AppSize.inset),
        ],
      ),
    );
  }
}
