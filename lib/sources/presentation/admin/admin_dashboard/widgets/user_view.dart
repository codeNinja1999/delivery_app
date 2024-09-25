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
    return Expanded(
      child: Container(
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
                    )),
              ],
            ),
            const SizedBox(height: AppSize.inset),
            BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
              buildWhen: (previous, current) => previous.userList != current.userList,
              builder: (context, state) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
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
                                  "Max ",
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
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
