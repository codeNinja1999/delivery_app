import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
        child: Column(
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
                    onPressed: () {},
                    child: Text(
                      "View All",
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
              ],
            ),
            const SizedBox(height: AppSize.inset),
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: AppSize.inset),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(AppSize.inset),
                    decoration: BoxDecoration(
                      color: AppColors.cardContainer,
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
            ),
          ],
        ),
      ),
    );
  }
}
