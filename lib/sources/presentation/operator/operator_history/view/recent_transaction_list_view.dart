import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/repository/domain/pickup_order/pickup_order_result.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:easy_localization/easy_localization.dart';

class RecentOrderHistoryListView extends StatelessWidget {
  const RecentOrderHistoryListView({super.key, this.onTap, this.data});
  final Function()? onTap;
  final PickupOrderResult? data;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Theme(
      data: ThemeData(
        highlightColor: theme.colorScheme.shadow,
        splashColor: theme.colorScheme.shadow,
      ),
      child: Container(
          margin: const EdgeInsets.only(top: AppSize.cornerRadiusMedium),
          padding: const EdgeInsets.all(AppSize.inset),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(AppSize.inset),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListItemView(
                title: (data?.createdAt != null) ? DateFormat('dd MMM yyyy').format(data!.createdAt!) : "",
                value: "\$${data?.orderPayments?[0].paidPrice}",
                titleTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                valueTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppSize.cornerRadiusMedium),
              Row(
                children: List.generate(
                  (MediaQuery.of(context).size.width / 19).floor(),
                  (ii) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        height: 2,
                        width: 8,
                        color: theme.colorScheme.primary,
                      )),
                ),
              ),
              const SizedBox(height: AppSize.cornerRadiusMedium),
              ListItemView(
                title: LocaleKeys.typeOfService.value,
                value: data?.services?.map((service) => service.value).join(', '), // Concatenate services
              ),
              const SizedBox(height: AppSize.cornerRadiusMedium),
              ListItemView(
                title: LocaleKeys.weightOfLaundry.value,
                value: "${data?.actualWeightInKg}kg",
              ),
              (data?.pickupLocation?.city != null)
                  ? Padding(
                      padding: const EdgeInsets.only(top: AppSize.cornerRadiusMedium),
                      child: ListItemView(
                        title: LocaleKeys.pickupAddress.value,
                        value: "${data?.pickupLocation?.city}, ${data?.pickupLocation?.neighborhood}",
                      ),
                    )
                  : Container(),
              const SizedBox(height: AppSize.cornerRadiusMedium),
              ListItemView(
                title: "Pickup Date",
                value: (data?.pickupTimeFrom != null) ? DateFormat('yyyy-MM-dd').format(data!.pickupTimeFrom!) : "",
              ),
              const SizedBox(height: AppSize.cornerRadiusMedium),
              ListItemView(
                title: "Pickup status",
                value: data?.status ?? "",
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
