import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

T? tryCast<T>(dynamic object) => object is T ? object : null;

enum DropdownType { menu, bottomSheet, dialog, modalBottomSheet }

class AppDropDown<T> extends StatefulWidget {
  const AppDropDown({
    super.key,
    this.title,
    this.textStyle,
    this.iconColor,
    this.titleColor,
    this.cornerRadius = AppSize.cornerRadiusMedium,
    this.itemAsString,
    this.items,
    this.selectedItem,
    this.enableSearch = true,
    this.dropdownType = DropdownType.modalBottomSheet,
    this.placeholder,
    this.onChanged,
    this.imageUrl,
    this.leadingIcon,
    this.validator,
    this.onFind,
    this.textController,
    this.enabled,
    this.fillColor,
    this.leadingInitial = false,
    this.urlI,
    this.isCountry,
    this.prefix,
    this.prefixIcon,
    this.focusNode,
    this.onPressed,
    this.suffixWidget,
    this.onBeforePopupOpening,
    this.prefixIconConstraints,
  });

  // Widget Config
  final String? title;
  final TextStyle? textStyle;
  final Color? iconColor;
  final Color? titleColor;
  final double cornerRadius;
  final FocusNode? focusNode;
  final Widget? prefix;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;

  // Dropdown Logic
  final DropdownType? dropdownType;
  final List<T>? items;
  final T? selectedItem;
  final bool enableSearch;
  final String? placeholder;
  final String? urlI;
  final IconData? leadingIcon;
  final String? imageUrl;
  final String? Function(T?)? validator;
  final Future<List<T>> Function(String?)? onFind;
  final String Function(T)? itemAsString;
  final Widget? suffixWidget;
  final bool? enabled;
  final bool? isCountry;
  final Color? fillColor;
  final TextEditingController? textController;
  final bool? leadingInitial;

  // Events
  final void Function(T)? onChanged;
  final Function()? onPressed;
  final Future<bool> Function(T?)? onBeforePopupOpening;

  @override
  State<AppDropDown<T>> createState() => _AppDropDownState<T>();
}

class _AppDropDownState<T> extends State<AppDropDown<T>> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String getInitials(String title) =>
      title.isNotEmpty ? title.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join() : '';

  Color getColorForName(String name) {
    int hash = utf8.encode(name).fold(0, (int result, int current) => result + current);
    return Colors.primaries[hash % Colors.primaries.length].withValues(alpha: 0.6);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        if (widget.title?.isNotEmpty ?? false) ...[
          Text(
            widget.title ?? '',
            style: widget.titleColor != null
                ? theme.textTheme.bodyMedium?.copyWith(color: widget.titleColor)
                : theme.textTheme.bodyMedium,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: AppSize.cornerRadiusMedium),
        ],
        Theme(
          data: theme.copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: IgnorePointer(
            ignoring: widget.items == null,
            child: DropdownSearch<T>(
              compareFn: (item1, item2) => true,
              popupProps: _popupProps(theme),
              itemAsString: widget.itemAsString,
              items: (widget.items == null)
                  ? null
                  : (String filter, LoadProps? prop) async {
                      return widget.items ?? [];
                    },
              selectedItem: widget.selectedItem,
              onChanged: (data) {
                if (widget.onChanged != null) {
                  _formKey.currentState?.validate();
                  widget.onChanged!(data as T);
                }
              },
              validator: widget.validator,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              enabled: widget.enabled ?? true,
              onBeforePopupOpening: (_) async {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
                return true;
              },
              suffixProps: DropdownSuffixProps(
                dropdownButtonProps: DropdownButtonProps(
                  focusNode: widget.focusNode,
                  iconOpened: widget.suffixWidget ?? _buildDropDownIcon(),
                  iconClosed: widget.suffixWidget ?? _buildDropDownIcon(),
                ),
              ),
              decoratorProps: DropDownDecoratorProps(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                baseStyle: widget.textStyle ?? theme.textTheme.bodyMedium?.copyWith(textBaseline: TextBaseline.alphabetic),
                decoration: InputDecoration(
                  hintText: widget.placeholder ?? '',
                  prefix: widget.prefix,
                  prefixIcon: widget.prefixIcon,
                  prefixIconConstraints: widget.prefixIconConstraints,
                  hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  counterText: "",
                  fillColor: widget.fillColor ?? Theme.of(context).colorScheme.surface,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSize.inset,
                    vertical: AppSize.cornerRadiusMedium,
                  ),
                  errorStyle: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                    borderSide: BorderSide(color: theme.colorScheme.outline),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                    borderSide: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                    borderSide: BorderSide(color: theme.colorScheme.secondary),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                    borderSide: BorderSide(color: theme.colorScheme.outline),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                    borderSide: BorderSide(color: theme.colorScheme.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSize.cornerRadiusMedium),
                    borderSide: BorderSide(color: theme.colorScheme.error),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Builds the dropdown arrow or loader
  Widget _buildDropDownIcon() {
    if (widget.items == null) {
      return const CupertinoActivityIndicator(color: Colors.red);
    }
    return Icon(
      Icons.keyboard_arrow_down_outlined,
      color: widget.iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }

  // Builds the popup dialog/sheet/menu for the dropdown
  PopupProps<T> _popupProps(ThemeData theme) {
    bool enableSearch = (widget.items?.length ?? 0) > 10;
    final dropdownType = widget.dropdownType ?? DropdownType.modalBottomSheet;

    Widget buildListTile(String data, String url, {Color? avatarBackgroundColor, bool? leadingInitial}) {
      if (widget.isCountry == true) {
        return ListTile(
          dense: true,
          leading: SvgPicture.network(
            url,
            height: 25,
            width: 25,
            placeholderBuilder: (context) => const SizedBox(
              height: 25,
              width: 25,
            ),
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              height: 25,
              width: 25,
            ),
          ),
          title: Text(data, style: theme.textTheme.labelLarge),
        );
      } else if (leadingInitial == true) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: avatarBackgroundColor,
            radius: 20,
            child: Text(getInitials(data), style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
          ),
          title: Text(data, style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
        );
      } else {
        return Text(data, style: theme.textTheme.labelLarge);
      }
    }

    Widget itemBuilder(context, item, _, __) {
      final receivingCountry = tryCast<T>(item);
      final nationality = tryCast<T>(item);
      final data = item.toString();
      final countryUrl = widget.urlI ?? AppConstants.countryImageUrl;

      final url = "";
      // widget.imageUrl == "nationality"
      //     ? "$countryUrl${(nationality)?.countryCodeCodeIso2?.toLowerCase()}.svg"
      //     : "$countryUrl${receivingCountry?.countryCodeIso2?.toLowerCase()}.svg";
      Color avatarBackgroundColor = getColorForName(data);

      if (widget.isCountry == true) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildListTile(data, url),
            Divider(color: theme.dividerColor),
          ],
        );
      } else if (widget.leadingInitial == true) {
        return buildListTile(data, url, avatarBackgroundColor: avatarBackgroundColor, leadingInitial: true);
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSize.inset * 0.5),
            Text(data, style: theme.textTheme.labelLarge),
            const SizedBox(height: AppSize.inset * 0.5),
            Divider(color: theme.dividerColor),
          ],
        );
      }
    }

    final searchFieldProps = TextFieldProps(
      style: theme.textTheme.bodyMedium,
      padding: const EdgeInsets.only(
        top: AppSize.viewSpacing,
        left: AppSize.viewMargin,
        right: AppSize.viewMargin,
      ),
      cursorColor: theme.primaryColor,
      decoration: InputDecoration(
        hintText: LocaleKeys.search.value,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w400,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: AppSize.inset),
          child: SvgPicture.asset(AppSvg.search, fit: BoxFit.scaleDown),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSize.inset,
          vertical: AppSize.cornerRadiusMedium,
        ),
        errorStyle: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.error),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.viewSpacing)),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.viewSpacing)),
          borderSide: BorderSide(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.viewSpacing)),
          borderSide: BorderSide(color: theme.colorScheme.secondary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.viewSpacing)),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.viewSpacing)),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.viewSpacing)),
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
      ),
    );

    const listViewProps = ListViewProps(
      padding: EdgeInsets.only(
        top: AppSize.viewSpacing,
        left: AppSize.viewMargin,
        right: AppSize.viewMargin,
      ),
    );

    switch (dropdownType) {
      case DropdownType.menu:
        return PopupPropsMultiSelection.menu(
          fit: FlexFit.loose,
          menuProps: MenuProps(
            elevation: 5,
            backgroundColor: theme.scaffoldBackgroundColor,
            shadowColor: Colors.black,
            barrierColor: Colors.black12,
          ),
          searchDelay: const Duration(milliseconds: 1),
          itemBuilder: itemBuilder,
          showSearchBox: enableSearch,
          searchFieldProps: searchFieldProps,
          listViewProps: listViewProps,
        );

      case DropdownType.bottomSheet:
        return PopupPropsMultiSelection.bottomSheet(
          fit: FlexFit.tight,
          onDismissed: () => true,
          searchDelay: const Duration(milliseconds: 1),
          itemBuilder: itemBuilder,
          showSearchBox: enableSearch,
          searchFieldProps: searchFieldProps,
          bottomSheetProps: BottomSheetProps(
            elevation: 100,
            backgroundColor: theme.scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSize.viewSpacing),
                topRight: Radius.circular(AppSize.viewSpacing),
              ),
              side: BorderSide(color: theme.disabledColor, width: 1),
            ),
            constraints: const BoxConstraints(maxWidth: double.infinity),
            clipBehavior: Clip.none,
          ),
          listViewProps: listViewProps,
        );

      case DropdownType.dialog:
        return PopupPropsMultiSelection.dialog(
          showSearchBox: true,
          searchDelay: const Duration(milliseconds: 1),
          itemBuilder: itemBuilder,
          searchFieldProps: searchFieldProps,
          listViewProps: listViewProps,
        );

      case DropdownType.modalBottomSheet:
        return PopupPropsMultiSelection.modalBottomSheet(
          showSearchBox: enableSearch,
          modalBottomSheetProps: ModalBottomSheetProps(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.viewSpacing),
                topRight: Radius.circular(AppSize.viewSpacing),
              ),
            ),
            backgroundColor: theme.scaffoldBackgroundColor,
          ),
          onDismissed: () => FocusManager.instance.primaryFocus?.unfocus(),
          searchDelay: const Duration(milliseconds: 1),
          itemBuilder: itemBuilder,
          searchFieldProps: searchFieldProps,
          listViewProps: listViewProps,
        );
    }
  }
}
