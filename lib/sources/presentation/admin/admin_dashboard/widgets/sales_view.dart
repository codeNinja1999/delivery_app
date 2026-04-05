import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/admin/admin_dashboard/admin_dashboard.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

class SalesView extends StatelessWidget {
  const SalesView({super.key});

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
      child: BlocBuilder<AdminDashboardBloc, AdminDashboardState>(
        buildWhen: (previous, current) => previous.analyticsInfo != current.analyticsInfo,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sales Summary",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "Total Sales: ฿130,980",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 50,
                child: Text(
                  "Chart",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                "Export Data",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: Text(
                        "User Data",
                        style: theme.textTheme.bodyMedium,
                      ),
                      side: BorderSide(color: AppColors.primary),
                      // backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium)),
                    ),
                  ),
                  const SizedBox(width: AppSize.inset),
                  GestureDetector(
                    onTap: () {},
                    child: Chip(
                      label: Text(
                        "Operator Data",
                        style: theme.textTheme.bodyMedium,
                      ),
                      side: BorderSide(color: AppColors.primary),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium)),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Chip(
                  label: Text(
                    "Pickup/delivery Data",
                    style: theme.textTheme.bodyMedium,
                  ),
                  side: BorderSide(color: AppColors.primary),
                  // backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium)),
                ),
              ),
              const SizedBox(height: AppSize.inset),
              CustomButton(backgroundColor: AppColors.primary, title: "Export to Excel", onPressed: () {})
            ],
          );
        },
      ),
    );
  }
}
