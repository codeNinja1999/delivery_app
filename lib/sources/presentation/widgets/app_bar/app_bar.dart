import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final TextStyle? titleStyle;
  final VoidCallback? backButtonAction;
  final Color? backgroundColor;
  final Color? backButtonBackgroundColor;
  final bool allowBack;
  final List<Widget>? actions;
  final Color? arrowColor;

  const MyAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.backgroundColor,
    this.backButtonAction,
    this.allowBack = true,
    this.backButtonBackgroundColor,
    this.actions,
    this.arrowColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: theme.colorScheme.shadow,
      leadingWidth: 65,
      leading: allowBack
          ? Padding(
              padding: const EdgeInsets.only(top: AppSize.inset, left: AppSize.viewMargin),
              child: GestureDetector(
                onTap: () {
                  if (FocusScope.of(context).hasFocus) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                  (backButtonAction != null) ? backButtonAction!() : Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.only(left: AppSize.cornerRadiusMedium),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                    border: Border.all(color: theme.colorScheme.outline),
                    color: backButtonBackgroundColor ?? AppColors.backgroundContainerLight,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: arrowColor ?? AppColors.black,
                  ),
                ),
              ),
            )
          : null,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      centerTitle: true,
      title: Text(
        title ?? "",
        style: titleStyle ?? theme.textTheme.titleLarge?.copyWith(fontSize: 18, color: theme.primaryColor),
      ),
      elevation: 0,
      iconTheme: theme.iconTheme,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
