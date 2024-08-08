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
            if (selectedIndex == 0) ...[
              const HomeView(),
            ],
            if (selectedIndex == 5) ...[
              const PriceView(),
            ]
          ]),
        ),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    color: theme.colorScheme.surfaceContainer,
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
                      CustomButton(title: "View Details", onPressed: () {})
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PriceView extends StatelessWidget {
  const PriceView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surfaceContainer,
      child: Column(
        children: [
          Table(
            border: const TableBorder(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                Text(
                  "Service Type",
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  "Price",
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  "Actions",
                  style: theme.textTheme.titleMedium,
                )
              ]),
              makeRow(
                theme,
                "Regular wash",
                "\$100/kg",
                () {},
                () {},
              ),
              makeRow(
                theme,
                "Dry Cleaning",
                "\$200/kg",
                () {},
                () {},
              ),
              makeRow(
                theme,
                "Ironing Only",
                "\$50/kg",
                () {},
                () {},
              ),
              makeRow(
                theme,
                "Service 4",
                "\$150/kg",
                () {},
                () {},
              ),
            ],
          ),
          const SizedBox(height: AppSize.inset),
          CustomButton(title: "Add New Service", onPressed: () {}),
        ],
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
