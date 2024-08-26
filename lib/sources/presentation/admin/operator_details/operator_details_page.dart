import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/admin/route/admin_route.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class OperatorDetailsPage extends StatelessWidget {
  const OperatorDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const MyAppBar(title: "Operators"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSize.inset),
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
            const SizedBox(height: AppSize.inset),
            CustomButton(
                title: "Edit Details",
                buttonType: ButtonType.bordered,
                onPressed: () {
                  Navigator.pushNamed(context, AdminRoute.updateOperator);
                }),
            const SizedBox(height: AppSize.inset),
            CustomButton(title: "Delete", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
