import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/admin/route/admin_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

import '../bloc/admin_dashboard_bloc.dart';

class PriceView extends StatelessWidget {
  const PriceView({super.key});

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
        buildWhen: (previous, current) => previous.serviceTypeList != current.serviceTypeList,
        builder: (context, state) {
          if (state.locationList == []) {
            return const SizedBox.expand(
              child: Center(child: Text("No Service")),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Service Type",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Price",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      "Actions",
                      style: theme.textTheme.titleMedium,
                    )
                  ],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.serviceTypeList?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSize.inset),
                  itemBuilder: (context, index) {
                    final service = state.serviceTypeList?[index];
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            service?.id ?? "",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${service?.price}",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
                const SizedBox(height: AppSize.inset),
                CustomButton(
                  backgroundColor: AppColors.primary,
                  title: "Add New Service",
                  onPressed: () {
                    Navigator.pushNamed(context, AdminRoute.addServicePrice);
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  TableRow makeRow(ThemeData theme, String id, String price, Function() onEdit, Function() onDelete) {
    return TableRow(
      children: [
        Text(
          id,
          style: theme.textTheme.titleMedium,
        ),
        Text(
          price,
          style: theme.textTheme.titleMedium,
        ),
        Row(
          children: [
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete),
            )
          ],
        ),
      ],
    );
  }
}
