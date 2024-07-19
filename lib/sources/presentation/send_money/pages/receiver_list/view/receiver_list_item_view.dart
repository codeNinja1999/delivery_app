import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../model/receiver_list_view_model.dart';

class ReceiverListItemView extends StatelessWidget {
  const ReceiverListItemView({super.key, this.data, this.onSelected});

  final ReceiverListViewModel? data;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onSelected,
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: (data?.receiverFlag != null || data?.receiverFlag != "")
            ? BorderImage(
                imageUrl: data!.receiverFlag!,
                size: AppSize.inset * 2,
              )
            : const Icon(Icons.error, size: AppSize.inset * 2),
      ),
      title: Text(
        data?.title ?? "",
        style: theme.textTheme.bodyLarge?.copyWith(
          color: (data?.isDisabledBeneficiary ?? true) ? AppColors.hintTextColor : AppColors.textColor,
        ),
      ),
      subtitle: Text(
        data?.subTitle ?? "",
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: (data?.isDisabledBeneficiary ?? true) ? AppColors.hintTextColor : AppColors.textColor,
        ),
      ),
    );
  }
}
