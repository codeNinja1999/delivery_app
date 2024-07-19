import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class CustomOtpDialog extends StatelessWidget {
  const CustomOtpDialog({
    super.key,
    this.imageString,
    required this.title,
    required this.senderNumber,
    required this.primaryButtonTitle,
    this.secondaryButtonTitle,
    required this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
  });

  final String title;
  final String? imageString;
  final String primaryButtonTitle;
  final String senderNumber;
  final String? secondaryButtonTitle;
  final Function() onPrimaryButtonPressed;
  final Function()? onSecondaryButtonPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String code = "";
    return Center(
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 40, horizontal: AppSize.inset),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.inset),
          color: theme.colorScheme.surface,
        ),
        width: MediaQuery.of(context).size.width - 24,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: theme.disabledColor,
                child: Image.asset(imageString ?? AppImages.logo, fit: BoxFit.cover),
              ),
              const SizedBox(height: AppSize.inset),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: AppSize.inset),
              Text(
                "Please enter the 6 digit code sent to your mobile number $senderNumber",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSize.viewMargin),
              Padding(
                padding: const EdgeInsets.only(left: AppSize.inset, right: AppSize.inset),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(child: OtpNumberKey(keyboardNumber: code.isNotEmpty ? code.substring(0, 1) : "")),
                    Expanded(child: OtpNumberKey(keyboardNumber: code.length > 1 ? code.substring(1, 2) : "")),
                    Expanded(child: OtpNumberKey(keyboardNumber: code.length > 2 ? code.substring(2, 3) : "")),
                    Expanded(child: OtpNumberKey(keyboardNumber: code.length > 3 ? code.substring(3, 4) : "")),
                    Expanded(child: OtpNumberKey(keyboardNumber: code.length > 4 ? code.substring(4, 5) : "")),
                    Expanded(child: OtpNumberKey(keyboardNumber: code.length > 5 ? code.substring(5, 6) : "")),
                  ],
                ),
              ),
              const SizedBox(height: AppSize.viewMargin),
              CustomButton(
                title: "Verify",
                onPressed: onPrimaryButtonPressed,
                buttonType: ButtonType.round,
              ),
              const SizedBox(height: AppSize.inset),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't get OTP?",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.hintTextColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (onSecondaryButtonPressed != null) {
                        onSecondaryButtonPressed!();
                      }
                    },
                    child: Text(
                      "Resend",
                      style: theme.textTheme.titleMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class OtpNumberKey extends StatefulWidget {
  OtpNumberKey({super.key, required this.keyboardNumber, this.obscureText});
  final String keyboardNumber;
  bool? obscureText = true;

  @override
  State<OtpNumberKey> createState() => _OtpNumberKeyState();
}

class _OtpNumberKeyState extends State<OtpNumberKey> {
  final TextEditingController _pinController = TextEditingController();
  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
        width: AppSize.buttonHeight,
        height: AppSize.buttonHeight,
        child: TextField(
          controller: _pinController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          obscureText: true,
          maxLength: 1,
          onChanged: (value) {
            setState(() {
              if (value.isNotEmpty) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            }); // To trigger a rebuild when text changes
          },
          decoration: InputDecoration(
            filled: (widget.keyboardNumber != "") ? true : false,
            counterText: '', // Hide the default character counter
            border: const OutlineInputBorder(borderSide: BorderSide.none), // Remove the underline border
          ),
        ),
      ),
    );
  }
}
