import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

enum ButtonType { primary, bordered, plain, round }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.height,
    this.buttonType = ButtonType.primary,
    this.width,
    this.isEnabled = true,
    this.backgroundColor,
    this.borderColor,
    this.gradientColors,
    this.leadingIcon,
    this.shadowColor,
    this.cornerRadius,
    this.titleColor,
    this.padding,
    this.textUnderline = false,
  });

  final String title;
  final GestureTapCallback? onPressed;
  final double? height;
  final double? width;
  final IconData? leadingIcon;
  final bool isEnabled;
  final ButtonType? buttonType;
  final Color? backgroundColor;
  final Color? borderColor;
  final List<Color>? gradientColors;
  final Color? shadowColor;
  final Color? titleColor;
  final double? cornerRadius;
  final EdgeInsetsGeometry? padding;
  final bool textUnderline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color? color = (backgroundColor == null)
        ? (buttonType == ButtonType.primary)
            ? theme.colorScheme.primary
            : Theme.of(context).scaffoldBackgroundColor
        : backgroundColor;

    final ShapeBorder? shape = buttonType == ButtonType.bordered
        ? RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(cornerRadius ?? AppSize.cornerRadiusMedium),
          )
        : null;
    final Color? foregroundColor = (buttonType == ButtonType.primary) ? Colors.white : titleColor;

    final contentPadding = padding ?? const EdgeInsets.all(AppSize.inset * 0.75);

    return Material(
      color: Colors.transparent,
      elevation: 0,
      shape: shape,
      child: CupertinoButton(
        minSize: height ?? 32,
        onPressed: isEnabled ? onPressed : null,
        padding: contentPadding,
        color: color,
        disabledColor: color?.withOpacity(0.5) ?? CupertinoColors.quaternarySystemFill,
        borderRadius: BorderRadius.circular(cornerRadius ?? AppSize.cornerRadiusMedium),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: theme.textTheme.titleMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w500,
              decoration: textUnderline ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
