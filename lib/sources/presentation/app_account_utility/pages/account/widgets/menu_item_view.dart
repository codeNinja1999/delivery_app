import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    this.onTap,
    required this.title,
    this.iconData,
    this.secondaryWidget,
    this.leadingWidget,
    this.trailingWidget,
  });
  final Function()? onTap;
  final String title;
  final IconData? iconData;
  final Widget? secondaryWidget;
  final Widget? leadingWidget;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: ThemeData(
        highlightColor: theme.colorScheme.shadow,
      ),
      child: ListTile(
        onTap: onTap,
        splashColor: theme.colorScheme.shadow,
        hoverColor: theme.colorScheme.shadow,
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 0,
        leading: (leadingWidget != null)
            ? leadingWidget!
            : (iconData != null)
                ? Icon(iconData, size: AppSize.viewMargin)
                : null,
        title: Text(title, style: theme.textTheme.titleMedium),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            (secondaryWidget != null) ? secondaryWidget! : Container(),
            (trailingWidget != null)
                ? trailingWidget!
                : SvgPicture.asset(AppSvg.arrowForwardSmall, height: AppSize.smallIconHeight),
          ],
        ),
      ),
    );
  }
}
