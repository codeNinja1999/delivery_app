import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../../route/admin_route.dart';
import '../bloc/admin_dashboard_bloc.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSize.inset),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "User Management",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AdminRoute.userList);
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
            buildWhen: (previous, current) => previous.userList != current.userList,
            builder: (context, state) {
              if (state.userList == []) {
                return SizedBox.expand(
                  child: Center(child: Text("No User", style: Theme.of(context).textTheme.bodyLarge)),
                );
              } else {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.userList?.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(height: AppSize.inset),
                  itemBuilder: (context, index) {
                    final user = state.userList?[index];
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
                                user?.personalInfo?.fullName ?? "",
                                style: theme.textTheme.titleMedium,
                              )),
                              Expanded(
                                child: Text(
                                  user?.personalInfo?.phoneNumber ?? "",
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
                                  (user?.contactInfo?.neighborhood != null)
                                      ? "${user?.contactInfo?.neighborhood} ${user?.contactInfo?.postalCode ?? ""}"
                                      : "",
                                  style: theme.textTheme.bodySmall,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
