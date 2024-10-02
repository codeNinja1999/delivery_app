import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

import '../../route/admin_route.dart';
import '../bloc/admin_dashboard_bloc.dart';

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
                      // flex: 2,
                      child: Text(
                        "State",
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: AppSize.cornerRadiusMedium),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Neighborhood",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: AppSize.inset),
                    Text(
                      "Actions",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                const SizedBox(height: AppSize.viewSpacing),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: state.locationList?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSize.inset),
                  itemBuilder: (context, index) {
                    final location = state.locationList?[index];
                    return Container(
                      // color: Colors.red,
                      child: Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            // flex: 2,
                            child: Text(
                              location?.city ?? "",
                              maxLines: 2,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(width: AppSize.cornerRadiusMedium),
                          Expanded(
                            flex: 1,
                            child: Text(
                              location?.neighborhood ?? "", textAlign: TextAlign.center,

                              // "adsfasdfadsfadsfdsfasdfadsfsdfsda",
                              maxLines: 2,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(width: AppSize.inset),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, AdminRoute.addLocation, arguments: location);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(AppSize.cornerRadiusSmall),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: AppSize.inset,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSize.cornerRadiusMedium),
                              GestureDetector(
                                onTap: () {
                                  context.read<AdminDashboardBloc>().add(DeleteLocation(location));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: AppSize.cornerRadiusMedium,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.redAccent.withOpacity(0.2),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: AppSize.inset,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSize.viewSpacing),
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
}
