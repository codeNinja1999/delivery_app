import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

// ignore: must_be_immutable
class WithdrawAppDropDown<T> extends StatelessWidget {
  WithdrawAppDropDown({
    super.key,
    this.appTitle,
    this.title,
    this.items,
    this.backButtonAction,
    this.itemBuilder,
    this.allowBack = true,
    this.onSelect,
    this.selectedValue,
  });
  final String? appTitle;
  final String? title;
  final bool allowBack;
  final List<T>? items;
  final VoidCallback? backButtonAction;
  final DropdownSearchPopupItemBuilder<T>? itemBuilder;
  final Function(T)? onSelect;
  T? selectedValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.bottomSheetTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.bottomSheetTheme.backgroundColor,
        title: Text(
          appTitle ?? "",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
        ),
        leading: allowBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: Theme.of(context).scaffoldBackgroundColor,
                onPressed: () {
                  if (FocusScope.of(context).hasFocus) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                  (backButtonAction != null) ? backButtonAction!() : Navigator.of(context).pop();
                },
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: AppSize.viewMargin, right: AppSize.viewMargin, top: AppSize.viewMargin),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: items?.length,
            itemBuilder: ((context, index) {
              return Container(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: InkWell(
                  onTap: () {
                    final ind = items?[index];
                    onSelect?.call(ind as T);
                    Navigator.of(context).pop();
                  },
                  child: Text(items?[index].toString() ?? ""),
                ),
              );
            })),
      ),
    );
  }
}
