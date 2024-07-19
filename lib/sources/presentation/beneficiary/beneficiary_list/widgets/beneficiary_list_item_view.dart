import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../model/beneficiary_list_view_model.dart';

class BeneficiaryListItemView extends StatelessWidget {
  const BeneficiaryListItemView({super.key, this.data, required this.onSelected});

  final BeneficiaryListViewModel? data;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: ThemeData(
        highlightColor: theme.colorScheme.shadow,
        splashColor: theme.colorScheme.shadow,
      ),
      child: ListTile(
        onTap: onSelected,
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSize.inset),
        leading: BorderImage(
          imageUrl: (data != null) ? data!.receiverFlag : AppConstants.defaultFlagUrl,
          size: AppSize.inset * 2,
        ),
        title: Container(
          margin: const EdgeInsets.only(bottom: 4),
          color: theme.colorScheme.surface,
          child: Text(data?.title ?? "", style: theme.textTheme.bodyLarge),
        ),
        subtitle: Container(
          color: theme.colorScheme.surface,
          child: Text(
            data?.subTitle ?? "",
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        trailing: Container(
          color: theme.colorScheme.surface,
          padding: const EdgeInsets.only(right: AppSize.cornerRadiusMedium),
          child: SvgPicture.asset(AppSvg.arrowForward, height: AppSize.inset * 0.9),
        ),
      ),
    );
  }
}
