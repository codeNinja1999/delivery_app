import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/admin/admin_dashboard/admin_dashboard.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

import '../../route/admin_route.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

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
        buildWhen: (previous, current) => previous.locationList != current.locationList,
        builder: (context, state) {
          if (state.locationList == []) {
            return const SizedBox.expand(
              child: Center(child: Text("No Location")),
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
                        "State",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Neighborhood",
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
                  itemCount: state.locationList?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSize.inset),
                  itemBuilder: (context, index) {
                    final location = state.locationList?[index];
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            location?.city ?? "",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            location?.neighborhood ?? "",
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AdminRoute.addLocation, arguments: location);
                                },
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
                // Table(
                //   border: const TableBorder(),
                //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                //   children: [
                //     TableRow(children: [
                //       Text(
                //         "State",
                //         style: theme.textTheme.titleMedium,
                //       ),
                //       Text(
                //         "Neighborhood",
                //         style: theme.textTheme.titleMedium,
                //       ),
                //       Text(
                //         "Actions",
                //         style: theme.textTheme.titleMedium,
                //       )
                //     ]),
                //     makeRow(
                //       theme,
                //       state.locationList?.first.city ?? "",
                //       state.locationList?.first.neighborhood ?? "",
                //       () {},
                //       () {},
                //     ),
                //     makeRow(
                //       theme,
                //       "Phrae",
                //       "Amphoe Mueang",
                //       () {},
                //       () {},
                //     ),
                //     makeRow(
                //       theme,
                //       "Maha Sarakham",
                //       "Kantharawichai ",
                //       () {},
                //       () {},
                //     ),
                //     makeRow(
                //       theme,
                //       "Kamphaeng Phet",
                //       "Mueang Loei",
                //       () {},
                //       () {},
                //     ),
                //     makeRow(
                //       theme,
                //       "Kanchanaburi",
                //       "Tha Li",
                //       () {},
                //       () {},
                //     ),
                //   ],
                // ),
                const SizedBox(height: AppSize.inset),
                CustomButton(
                  backgroundColor: AppColors.primary,
                  title: "Add New Location",
                  onPressed: () {
                    Navigator.pushNamed(context, AdminRoute.addLocation);
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
