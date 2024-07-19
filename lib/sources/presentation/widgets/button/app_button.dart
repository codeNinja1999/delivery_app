import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

enum ButtonBorder { primary, bordered, round }

class AppButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String title;
  final TextStyle? titleTextStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? trailingIcon;
  final IconData? leadingIcon;
  final double? leadingIconSize;
  final Widget? child;
  final ButtonBorder? buttonType;
  final bool isEnabled;
  final double? cornerRadius;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.titleTextStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.trailingIcon,
    this.leadingIcon,
    this.leadingIconSize,
    this.child,
    this.buttonType = ButtonBorder.primary,
    this.isEnabled = true,
    this.cornerRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      style: buttonStyle(theme),
      onPressed: isEnabled ? onPressed : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.inset,
          vertical: AppSize.cornerRadiusSmall,
        ),
        child: FittedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (leadingIcon != null) ...[
                Icon(leadingIcon, color: theme.colorScheme.surface, size: leadingIconSize),
                const SizedBox(width: AppSize.cornerRadiusSmall),
                Text(title, maxLines: 1, style: titleTextStyle),
              ] else if (trailingIcon != null) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 130, right: 100),
                  child: Text(title.toUpperCase(), maxLines: 1),
                ),
                Icon(trailingIcon),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    title,
                    maxLines: 1,
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle? buttonStyle(ThemeData theme) {
    if (buttonType == ButtonBorder.round) {
      return theme.textButtonTheme.style?.copyWith(
        textStyle: titleTextStyle != null
            ? WidgetStateProperty.all<TextStyle>(titleTextStyle!)
            : theme.textButtonTheme.style!.textStyle,
        shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
        backgroundColor: backgroundColor != null
            ? WidgetStateProperty.all<Color>(backgroundColor!)
            : theme.textButtonTheme.style!.backgroundColor,
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              cornerRadius ?? AppSize.viewMargin,
            ),
          ),
        ),
      );
    } else if (buttonType == ButtonBorder.bordered) {
      return theme.textButtonTheme.style?.copyWith(
        textStyle: titleTextStyle != null
            ? WidgetStateProperty.all<TextStyle>(theme.textTheme.bodyLarge!.copyWith(color: theme.disabledColor))
            : WidgetStateProperty.all(theme.textTheme.bodyLarge!.copyWith(color: theme.disabledColor)),
        foregroundColor: foregroundColor != null
            ? WidgetStateProperty.all<Color>(foregroundColor!)
            : WidgetStateProperty.all<Color>(theme.colorScheme.primary),
        backgroundColor: backgroundColor != null
            ? WidgetStateProperty.all<Color>(backgroundColor!)
            : WidgetStateProperty.all(theme.colorScheme.shadow),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              cornerRadius ?? AppSize.cornerRadiusMedium,
            ),
            // side: BorderSide(
            //   color: theme.textTheme.bodySmall?.color ?? theme.primaryColorLight,
            // ),
          ),
        ),
      );
    } else {
      return theme.textButtonTheme.style;
    }
  }
}
