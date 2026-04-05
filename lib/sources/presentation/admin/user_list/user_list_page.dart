import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/admin/route/admin_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppPage.scroll(
      appBar: const MyAppBar(title: "User"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSize.inset),
            Row(
              children: [
                const Expanded(
                    child: CustomTextField(
                  prefixIcon: Icon(Icons.search),
                  placeholder: "Search for user",
                )),
                const SizedBox(width: AppSize.inset),
                CustomButton(title: "Search", onPressed: () {}),
              ],
            ),
            const SizedBox(height: AppSize.inset),
            Text(
              "All users",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSize.inset),
            ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: AppSize.inset),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AdminRoute.userDetails);
                  },
                  child: Container(
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
                      ],
                    ),
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
