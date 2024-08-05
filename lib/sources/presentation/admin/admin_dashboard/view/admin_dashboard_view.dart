import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/resources/app_colors.dart';
import '../bloc/admin_dashboard_bloc.dart';

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

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  int selectedIndex = 0;

  final list = ["Home", "User", "Operator", "Location", "Sales", "Pricing"];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<AdminDashboardBloc, AdminDashboardState>(
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
        child: Padding(
          padding: const EdgeInsets.all(AppSize.viewMargin),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${getGreeting()} ${LocaleKeys.appName.value}", style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: AppSize.viewSpacing),
            Text("Admin", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSize.viewSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(""),
                GestureDetector(
                  onTap: () {},
                  child: Chip(
                    label: const Text("Filter"),
                    side: BorderSide(color: theme.colorScheme.primary),
                    // labelStyle: TextStyle(color: (state.isPickupOrder) ? Colors.white : Colors.black),
                    // backgroundColor:
                    //     (state.isPickupOrder) ? theme.colorScheme.primary : theme.colorScheme.surfaceContainer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.inset)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.inset),
            Container(
              padding: const EdgeInsets.all(AppSize.inset * 0.75),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                color: AppColors.cardDark,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Analytics",
                          style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Today",
                          style:
                              theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: HexColor("#9F9F9F")),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.inset),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total active request",
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "6",
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.inset),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total user",
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "4",
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.inset),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Total operator",
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "10",
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: AppSize.inset),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Sales Summary",
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$8,000",
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Chip(
                      label: Text(list[index]),
                      side: BorderSide(color: theme.colorScheme.shadow),
                      labelStyle: TextStyle(
                        color: selectedIndex == index ? theme.colorScheme.surfaceContainer : AppColors.darkTextColor,
                      ),
                      backgroundColor: selectedIndex == index ? theme.colorScheme.primary : theme.colorScheme.shadow,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium)),
                    ),
                  );
                },
              ),
            ),
            Text("Hello"),
          ]),
        ),
      ),
    );
  }
}
