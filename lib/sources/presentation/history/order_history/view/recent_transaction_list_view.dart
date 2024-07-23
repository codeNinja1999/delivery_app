import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../model/transaction_list_view_model.dart';

class RecentOrderHistoryListView extends StatelessWidget {
  const RecentOrderHistoryListView({super.key, this.data, this.onTap});
  final TransactionListViewModel? data;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Theme(
      data: ThemeData(
        highlightColor: theme.colorScheme.shadow,
        splashColor: theme.colorScheme.shadow,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.inset,
          vertical: AppSize.cornerRadiusMedium,
        ),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.zero,
          dense: true,
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.secondaryContainer,
            child: SvgPicture.asset(AppSvg.transferIcon),
          ),
          title: Container(
            margin: const EdgeInsets.only(bottom: 4),
            color: theme.colorScheme.surface,
            child: Text(
              data?.beneficiaryName ?? "",
              style: theme.textTheme.titleMedium,
            ),
          ),
          subtitle: Container(
            color: theme.colorScheme.surface,
            child: Text(
              data?.date ?? "",
              style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400, fontSize: AppSize.inset * 0.75),
            ),
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                color: theme.colorScheme.surface,
                child: Text(
                  data?.amount ?? "",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              TransactionStatusColorMappingView(transactionStatus: data?.transactionStatus),
            ],
          ),
        ),
      ),
    );
  }
}
