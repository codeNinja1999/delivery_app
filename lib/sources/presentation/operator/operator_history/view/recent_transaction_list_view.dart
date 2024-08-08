import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class RecentOrderHistoryListView extends StatelessWidget {
  const RecentOrderHistoryListView({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Theme(
      data: ThemeData(
        highlightColor: theme.colorScheme.shadow,
        splashColor: theme.colorScheme.shadow,
      ),
      child: Container(
          padding: const EdgeInsets.only(
            left: AppSize.inset,
            top: AppSize.inset,
            bottom: AppSize.inset,
            right: AppSize.inset,
          ),
          // margin: const EdgeInsets.all(AppSize.viewMargin),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(AppSize.inset),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListItemView(
                title: "08 Feb 2024",
                value: "฿2200",
                titleTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                valueTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppSize.inset),
              Row(
                children: List.generate(
                  20,
                  (ii) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        height: 2,
                        width: 8,
                        color: theme.colorScheme.primary,
                      )),
                ),
              ),
              const SizedBox(height: AppSize.inset),
              ListItemView(
                title: LocaleKeys.typeOfService.value,
                value: "Regular wash",
              ),
              const SizedBox(height: AppSize.inset),
              ListItemView(
                title: LocaleKeys.weightOfLaundry.value,
                value: "12kg",
              ),
              const SizedBox(height: AppSize.inset),
              ListItemView(
                title: LocaleKeys.pickupAddress.value,
                value: "Phuket, Ban Tawan, 1415 Unit Near ABC Bus Stand ",
              ),
              const SizedBox(height: AppSize.inset),
              ListItemView(
                title: LocaleKeys.deliveryDateAndTime.value,
                value: "10 Feb 2024, 8-9AM",
              ),
            ],
          )),
    );
  }
}

class ListItemView extends StatelessWidget {
  final String title;
  final String? value;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;
  const ListItemView({
    super.key,
    required this.title,
    this.value,
    this.titleTextStyle,
    this.valueTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: (titleTextStyle != null)
                ? titleTextStyle
                : Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700, color: AppColors.greyColor),
          ),
        ),
        Expanded(
          child: Text(
            value ?? "",
            textAlign: TextAlign.end,
            style: (valueTextStyle != null)
                ? valueTextStyle
                : Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
