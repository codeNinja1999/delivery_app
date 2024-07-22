import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';

class AppTextfield extends StatefulWidget {
  AppTextfield({
    super.key,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.cornerRadius = AppSize.cornerRadiusMedium,
    this.fillColor,
    this.shadowColor,
    this.titleColor,
    this.title,
    this.prefixText,
    this.placeHolder,
    this.textInputAction,
    this.trailingIcon,
    this.validator,
    this.errorColor,
    this.onChanged,
    this.maxLength,
    this.maxLine = 1,
    this.controller,
    this.enabled = true,
    this.textInputType,
    this.errorMessage,
    this.helperMessage,
    this.textCapitalization = TextCapitalization.none,
    this.isObscure,
    this.autoFocus,
    this.focusNode,
    this.obscureSign = "•",
  }) {
    assert(obscureSign.length == 1);
  }

  final List<TextInputFormatter>? inputFormatters;
  final String obscureSign;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final double cornerRadius;
  final Color? shadowColor;
  final Color? titleColor;
  final bool? isObscure;
  final IconData? trailingIcon;
  final Color? fillColor;
  final String? title;
  final String? prefixText;
  final String? placeHolder;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Color? errorColor;
  final TextCapitalization textCapitalization;
  final FormFieldSetter? onChanged;
  final int? maxLength;
  final int? maxLine;
  final TextEditingController? controller;
  final bool? enabled;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final String? errorMessage, helperMessage;

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  var isSecureNow = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title ?? '',
          style: widget.titleColor != null
              ? Theme.of(context).textTheme.bodyLarge?.copyWith(color: widget.titleColor)
              : Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: AppSize.inset * 0.75),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          maxLines: widget.maxLine,
          obscuringCharacter: widget.obscureSign,
          inputFormatters: widget.inputFormatters,
          cursorColor: theme.primaryColor,
          textCapitalization: widget.textCapitalization,
          enabled: widget.enabled,
          controller: widget.controller,
          onChanged: widget.onChanged,
          validator: widget.validator,
          maxLength: (widget.isObscure ?? false) ? 20 : widget.maxLength,
          textInputAction: widget.textInputAction,
          style: theme.textTheme.bodyLarge,
          autofocus: widget.autoFocus ?? false,
          focusNode: widget.focusNode,
          keyboardType: widget.textInputType,
          obscureText: (widget.isObscure ?? false) ? isSecureNow : false,
          decoration: InputDecoration(
            prefix: widget.prefix,
            suffix: widget.suffix,
            suffixIcon: (widget.suffixIcon != null)
                ? widget.suffixIcon
                : widget.isObscure ?? false
                    ? IconButton(
                        icon: Icon(
                          isSecureNow ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: theme.iconTheme.color,
                        ),
                        onPressed: () {
                          setState(() {
                            isSecureNow = !isSecureNow;
                          });
                        })
                    : widget.trailingIcon != null
                        ? Icon(widget.trailingIcon)
                        : null,
            prefixIcon: (widget.prefixIcon != null) ? widget.prefixIcon : null,
            prefixText: widget.prefixText,
            errorText: widget.errorMessage,
            errorMaxLines: 3,
            hintText: widget.placeHolder ?? '',
            hintStyle: theme.textTheme.bodyLarge?.copyWith(color: AppColors.placeholder, fontWeight: FontWeight.w400),
            counterText: "",
            counter: const Offstage(),
            fillColor: widget.fillColor ?? theme.colorScheme.surfaceContainer,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSize.inset,
              vertical: AppSize.cornerRadiusMedium,
            ),
            errorStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(widget.cornerRadius),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(widget.cornerRadius),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.colorScheme.primary),
                borderRadius: BorderRadius.circular(widget.cornerRadius)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.cornerRadius),
              borderSide: BorderSide(color: theme.colorScheme.outline),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.cornerRadius),
              borderSide: BorderSide(color: theme.colorScheme.error, width: 0.8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.cornerRadius),
              borderSide: BorderSide(color: theme.colorScheme.error, width: 0.8),
            ),
          ),
        ),
      ],
    );
  }
}
