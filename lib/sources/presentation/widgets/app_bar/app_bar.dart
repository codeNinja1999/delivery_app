import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? backButtonAction;
  final Color? backgroundColor;
  final bool allowBack;
  final List<Widget>? actions;
  final Color? arrowColor;
  const MyAppBar({
    super.key,
    this.title,
    this.backgroundColor,
    this.backButtonAction,
    this.allowBack = true,
    this.actions,
    this.arrowColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Theme.of(context).colorScheme.shadow,
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
                    border: Border.all(color: Theme.of(context).colorScheme.outline),
                    color: Theme.of(context).colorScheme.surfaceContainer,
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
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surface,
      centerTitle: true,
      title: Text(
        title ?? "",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      elevation: 0,
      iconTheme: Theme.of(context).iconTheme,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
