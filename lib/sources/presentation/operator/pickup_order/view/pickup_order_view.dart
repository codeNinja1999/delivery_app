import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../bloc/pickup_order_bloc.dart';

class PickupOrderView extends StatefulWidget {
  const PickupOrderView({super.key});

  @override
  State<PickupOrderView> createState() => _PickupOrderViewState();
}

class _PickupOrderViewState extends State<PickupOrderView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PickupOrderBloc, PickupOrderState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        if (status is Success) {
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: const OrderHistoryListView(),
    );
  }
}

class OrderHistoryListView extends StatelessWidget {
  const OrderHistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSize.viewMargin),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "User Information",
              style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary),
            ),
            const SizedBox(height: AppSize.viewSpacing),
            Row(
              children: [
                Expanded(child: Text("Customer Name")),
                Expanded(
                  child: Text(
                    "John doe",
                    style: theme.textTheme.labelLarge,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.inset),
            Row(
              children: [
                Expanded(child: Text("Address Name")),
                Expanded(
                  child: Text(
                    "123 Street Name",
                    style: theme.textTheme.labelLarge,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.inset),
            Row(
              children: [
                Expanded(child: Text("Contact Number")),
                Expanded(
                  child: Text(
                    "(989)-223-222",
                    style: theme.textTheme.labelLarge,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.inset),
            Row(
              children: [
                Expanded(child: Text("Home Number Name")),
                Expanded(
                  child: Text(
                    "1415",
                    style: theme.textTheme.labelLarge,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.inset),
            Row(
              children: [
                Expanded(child: Text("Dropbox Number")),
                Expanded(
                  child: Text(
                    "1223",
                    style: theme.textTheme.labelLarge,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.inset),
            Row(
              children: [
                Expanded(child: Text("Service Type")),
                Expanded(
                  child: Text(
                    "Regular washing",
                    style: theme.textTheme.labelLarge,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.inset),
            Row(
              children: [
                Expanded(child: Text("Total weight")),
                Expanded(
                  child: Text(
                    "12kg",
                    style: theme.textTheme.labelLarge,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.inset),
            Text("Image"),
            const SizedBox(height: AppSize.inset),
            AppTextfield(
              title: "Review",
              placeHolder: "Add review",
            ),
          ],
        ),
      ),
    );
  }
}
