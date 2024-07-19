import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class CustomInformationBox extends StatelessWidget {
  const CustomInformationBox({
    super.key,
    required this.title,
    this.subTitle,
    this.onTap,
    this.trailing,
    this.titleTextStyle,
    this.leading,
    this.subTitleTextStyle,
  });
  final String title;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final String? subTitle;
  final Function()? onTap;
  final Widget? trailing;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
        color: theme.colorScheme.secondaryContainer,
        border: Border.all(color: theme.colorScheme.tertiary),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSize.inset),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 0,
        onTap: onTap,
        leading: (leading != null)
            ? leading
            : SvgPicture.asset(
                AppSvg.information,
                height: AppSize.viewSpacing,
              ),
        title: Text(
          title,
          style: (titleTextStyle != null) ? titleTextStyle : theme.textTheme.bodyMedium,
        ),
        subtitle: (subTitle != null)
            ? Text(
                subTitle!,
                style: (subTitleTextStyle != null)
                    ? subTitleTextStyle
                    : theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
              )
            : null,
        trailing: trailing,
      ),
    );
  }
}
