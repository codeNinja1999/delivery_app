import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../bloc/operator_dash_board_bloc.dart';
import '../widgets/shortcut_action_view.dart';

String getGreeting() {
  DateTime now = DateTime.now();
  int hour = now.hour;
  if (hour < 12) {
    return LocaleKeys.goodMorning.value;
  } else if (hour < 18) {
    return LocaleKeys.goodAfternoon.value;
  } else {
    return LocaleKeys.goodEvening.value;
  }
}

class OperatorDashboardView extends StatelessWidget {
  const OperatorDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<OperatorDashBoardBloc, OperatorDashBoardState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getGreeting(), style: theme.textTheme.bodyLarge),
            const SizedBox(height: AppSize.cornerRadiusMedium),
            Text("Operator", style: theme.textTheme.bodyLarge),
            const SizedBox(height: AppSize.viewSpacing),
            const ShortcutActionView(),
            const SizedBox(height: AppSize.viewSpacing),
            BlocBuilder<OperatorDashBoardBloc, OperatorDashBoardState>(
              buildWhen: (previous, current) => previous.isPickupOrder != current.isPickupOrder,
              builder: (context, state) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<OperatorDashBoardBloc>().add(TogglePickupOrder());
                      },
                      child: Chip(
                        label: const Text("Pickup Orders"),
                        side: BorderSide(color: theme.colorScheme.primary),
                        labelStyle: TextStyle(color: (state.isPickupOrder) ? Colors.white : Colors.black),
                        backgroundColor:
                            (state.isPickupOrder) ? theme.colorScheme.primary : Theme.of(context).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.inset)),
                      ),
                    ),
                    const SizedBox(width: AppSize.inset),
                    GestureDetector(
                      onTap: () {
                        context.read<OperatorDashBoardBloc>().add(TogglePickupOrder());
                      },
                      child: Chip(
                        label: const Text("Delivery Orders"),
                        side: BorderSide(color: theme.colorScheme.primary),
                        labelStyle: TextStyle(color: (state.isPickupOrder) ? Colors.black : Colors.white),
                        backgroundColor:
                            (state.isPickupOrder) ? Theme.of(context).scaffoldBackgroundColor : theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.inset)),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSize.viewSpacing),
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
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                      border: Border.all(color: Theme.of(context).colorScheme.outline),
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
                              ),
                            ),
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
                              ),
                            ),
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
                        CustomButton(title: "Accept", onPressed: () {})
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
