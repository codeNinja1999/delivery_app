import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSize.inset),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
          color: AppColors.cardDark,
        ),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Table(
                  border: const TableBorder(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(children: [
                      Text(
                        "State",
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        "Neighborhood",
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        "Actions",
                        style: theme.textTheme.titleMedium,
                      )
                    ]),
                    makeRow(
                      theme,
                      "Phuket",
                      "Talat yei",
                      () {},
                      () {},
                    ),
                    makeRow(
                      theme,
                      "Phrae",
                      "Amphoe Mueang",
                      () {},
                      () {},
                    ),
                    makeRow(
                      theme,
                      "Maha Sarakham",
                      "Kantharawichai ",
                      () {},
                      () {},
                    ),
                    makeRow(
                      theme,
                      "Kamphaeng Phet",
                      "Mueang Loei",
                      () {},
                      () {},
                    ),
                    makeRow(
                      theme,
                      "Kanchanaburi",
                      "Tha Li",
                      () {},
                      () {},
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.inset),
                CustomButton(
                  backgroundColor: AppColors.primary,
                  title: "Add New Location",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
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
