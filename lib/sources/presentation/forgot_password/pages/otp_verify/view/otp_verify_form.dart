import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/forgot_password_bloc.dart';
import '../../../route/reset_password_route.dart';
import '../bloc/otp_verify_bloc.dart';

String strDigits(int n) => n.toString().padLeft(2, '0');

class OtpVerifyForm extends StatelessWidget {
  OtpVerifyForm({super.key});

  final formKey = GlobalKey<FormState>();
  final String code = "";
  // final int numDigitType = 6;

  // final TextEditingController _fieldOne = TextEditingController();
  // final TextEditingController _fieldTwo = TextEditingController();
  // final TextEditingController _fieldThree = TextEditingController();
  // final TextEditingController _fieldFour = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<OtpVerifyBloc, OtpVerifyState>(
      listener: (context, state) {
        final status = state.status;
        final mainBloc = context.read<ForgotPasswordBloc>();

        status is InProgress ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          mainBloc.add(SaveResetProcessID(state.processID ?? ""));
          Navigator.of(context).pushReplacementNamed(ResetPasswordRoute.resetPassword);
        } else if (status is ResendResetOTPSuccess) {
          SnackbarUtils.showSnackbar(
            context,
            message: (mainBloc.state.isEmail)
                ? LocaleKeys.successfullySendOtpToYourEmail.value
                : LocaleKeys.successfullySendOtpToYourNumber.value,
            icon: Icons.check,
            type: SnackBarType.success,
          );
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSize.spacedViewSpacing),

                    Text(LocaleKeys.verificationCode.value, style: theme.textTheme.titleMedium?.copyWith(fontSize: 36)),
                    const SizedBox(height: AppSize.inset),
                    Text(LocaleKeys.verificationCodeSentMessage.tr(args: ["example@gmail.com"]),
                        style: theme.textTheme.bodyLarge),
                    const SizedBox(height: AppSize.viewSpacing),
                    const PinputExample(),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: AppSize.inset, bottom: AppSize.cornerRadiusSmall * 2),
                    //   child: Row(
                    //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       RegisterOtpInput(
                    //         first: true,
                    //         last: false,
                    //         controller: _fieldOne,
                    //       ),
                    //       RegisterOtpInput(
                    //         first: false,
                    //         last: false,
                    //         controller: _fieldTwo,
                    //       ),
                    //       RegisterOtpInput(
                    //         first: false,
                    //         last: false,
                    //         controller: _fieldThree,
                    //       ),
                    //       RegisterOtpInput(
                    //         first: false,
                    //         last: false,
                    //         controller: _fieldFour,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.viewSpacing),
                    child: BlocBuilder<OtpVerifyBloc, OtpVerifyState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(AppSize.inset),
                              child: (state.resendDuration.inSeconds) >= 0
                                  ? RichText(
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.visible,
                                      text: TextSpan(
                                        text: LocaleKeys.didNotGeTheCodeResendIn.value,
                                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                                        children: [
                                          TextSpan(
                                            text:
                                                "${strDigits(state.resendDuration.inMinutes.remainder(60))}:${strDigits(state.resendDuration.inSeconds.remainder(60))}",
                                            style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
                                          ),
                                        ],
                                      ),
                                    )
                                  : RichText(
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.visible,
                                      text: TextSpan(
                                        text: LocaleKeys.didNotGeTheCode.value,
                                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                                        children: [
                                          TextSpan(
                                            text: LocaleKeys.resendOtp.value,
                                            style: theme.textTheme.titleMedium?.copyWith(
                                              color: theme.colorScheme.error,
                                              decoration: TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                final mainState = context.read<ForgotPasswordBloc>().state;
                                                context.read<OtpVerifyBloc>().add(
                                                      ResendOtp(
                                                        recepient: mainState.loginId,
                                                        isEmail: mainState.isEmail,
                                                      ),
                                                    );
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            DividerButton(
                              nextTitle: LocaleKeys.submit.value,
                              nextButtonAction: () {
                                Navigator.of(context).pushReplacementNamed(ResetPasswordRoute.resetPassword);

                                // if (_fieldOne.text != "" &&
                                //     _fieldTwo.text != "" &&
                                //     _fieldThree.text != "" &&
                                //     _fieldFour.text != "") {
                                //   var otpCode = _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text;
                                //   final resetState = context.read<ForgotPasswordBloc>().state;
                                //   context.read<OtpVerifyBloc>().add(
                                //         VerifyResetOTP(
                                //           verificationCode: otpCode,
                                //           processID: state.processID ?? resetState.otpVerifyProcessID,
                                //           isEmail: resetState.isEmail,
                                //         ),
                                //       );
                                // }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterOtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool? first;
  final bool? last;
  const RegisterOtpInput({
    super.key,
    required this.controller,
    this.first,
    this.last,
  });
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.cornerRadiusSmall),
        width: AppSize.inset,
        height: AppSize.buttonHeight,
        child: TextField(
          // inputFormatters: [
          //   FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
          // ],
          autofocus: true,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          controller: controller,
          maxLength: 1,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.disabledColor),
                borderRadius: BorderRadius.circular(4),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.disabledColor),
                borderRadius: BorderRadius.circular(4),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              counterText: '',
              hintStyle: TextStyle(color: Theme.of(context).disabledColor, fontSize: 20.0)),
          onChanged: (mobileNumber) {
            if (mobileNumber.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (mobileNumber.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }
}
