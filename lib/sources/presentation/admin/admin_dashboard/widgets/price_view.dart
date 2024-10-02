import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

import '../../route/admin_route.dart';
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
                      // flex: 2,
                      child: Text(
                        "Service Type",
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: AppSize.cornerRadiusMedium),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Price",
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
                  itemCount: state.serviceTypeList?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSize.inset),
                  itemBuilder: (context, index) {
                    final service = state.serviceTypeList?[index];
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
                              service?.value ?? "",
                              maxLines: 2,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(width: AppSize.cornerRadiusMedium),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "\$${service?.price}/kg",
                              textAlign: TextAlign.center,
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
                                  Navigator.pushNamed(context, AdminRoute.addServicePrice, arguments: service);
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
                                  context.read<AdminDashboardBloc>().add(DeleteService(service));
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
}
