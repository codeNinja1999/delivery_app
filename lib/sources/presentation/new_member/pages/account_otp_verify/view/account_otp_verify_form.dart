import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../../bloc/new_member_bloc.dart';
import '../../../route/new_member_route.dart';
import '../bloc/account_otp_verify_bloc.dart';

class OtpVerifyForm extends StatefulWidget {
  const OtpVerifyForm({super.key});

  @override
  State<OtpVerifyForm> createState() => _OtpVerifyFormState();
}

class _OtpVerifyFormState extends State<OtpVerifyForm> {
  var formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final dataKey = GlobalKey();

  // final TextEditingController _fieldOne = TextEditingController();
  // final TextEditingController _fieldTwo = TextEditingController();
  // final TextEditingController _fieldThree = TextEditingController();
  // final TextEditingController _fieldFour = TextEditingController();
  // final TextEditingController _fieldFive = TextEditingController();
  // final TextEditingController _fieldSix = TextEditingController();

  String strDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void initState() {
    _focusNode.addListener(() async {
      if (_focusNode.hasFocus) {
        await Future.delayed(const Duration(milliseconds: 300));
        Scrollable.ensureVisible(
          dataKey.currentContext!,
          duration: const Duration(milliseconds: 200),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AccountOtpVerifyBloc, AccountOtpVerifyState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        final mainBloc = context.read<NewMemberBloc>();
        status is InProgress ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          mainBloc.add(SaveRegisterProcessID(state.processID ?? ""));
          Navigator.pushReplacementNamed(context, NewMemberRoute.registerForm);
        } else if (status is ResendRegisterOTPSuccess) {
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
      child: Padding(
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
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
                    const SizedBox(height: AppSize.inset),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     RegisterOtpInput(
                    //       first: true,
                    //       last: false,
                    //       controller: _fieldOne,
                    //     ),
                    //     RegisterOtpInput(
                    //       first: false,
                    //       last: false,
                    //       controller: _fieldTwo,
                    //     ),
                    //     RegisterOtpInput(
                    //       first: false,
                    //       last: false,
                    //       controller: _fieldThree,
                    //     ),
                    //     RegisterOtpInput(
                    //       first: false,
                    //       last: false,
                    //       controller: _fieldFour,
                    //     ),
                    //     RegisterOtpInput(
                    //       first: false,
                    //       last: false,
                    //       controller: _fieldFive,
                    //     ),
                    //     RegisterOtpInput(
                    //       first: false,
                    //       last: true,
                    //       controller: _fieldSix,
                    //     ),
                    //   ],
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: AppSize.inset * 0.75),
                    //   child: Text("Wrong verification code! Please try again!",
                    //       style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400)),
                    // ),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: BlocBuilder<AccountOtpVerifyBloc, AccountOtpVerifyState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Spacer(),
                        const SizedBox(height: AppSize.spacedViewSpacing),
                        (state.resendDuration.inSeconds) >= 0
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
                                          final mainState = context.read<NewMemberBloc>().state;
                                          context.read<AccountOtpVerifyBloc>().add(
                                                ResendOtp(
                                                  recipient: mainState.userName,
                                                  isEmail: mainState.isEmail,
                                                ),
                                              );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                        BlocBuilder<AccountOtpVerifyBloc, AccountOtpVerifyState>(
                          buildWhen: (previous, current) => previous.processID != current.processID,
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
                              child: CustomButton(
                                title: LocaleKeys.nextButtonTitle.value,
                                onPressed: () {
                                  KeyboardUtil.hideKeyboard(context);
                                  Navigator.pushReplacementNamed(context, NewMemberRoute.registerForm);

                                  // if (_fieldOne.text != "" &&
                                  //     _fieldTwo.text != "" &&
                                  //     _fieldThree.text != "" &&
                                  //     _fieldFour.text != "" &&
                                  //     _fieldFive.text != "" &&
                                  //     _fieldSix.text != "") {
                                  //   var otpCode = _fieldOne.text +
                                  //       _fieldTwo.text +
                                  //       _fieldThree.text +
                                  //       _fieldFour.text +
                                  //       _fieldFive.text +
                                  //       _fieldSix.text;
                                  //   final mainState = context.read<NewMemberBloc>().state;
                                  //   context.read<AccountOtpVerifyBloc>().add(
                                  //         VerifyNewAccountOTP(
                                  //           processID: state.processID ?? mainState.verificationProcessID,
                                  //           verificationCode: otpCode,
                                  //           verifyBy: mainState.isEmail ? VerifyBy.email : VerifyBy.mobileNumber,
                                  //         ),
                                  //       );
                                  // }
                                },
                              ),
                            );
                          },
                        ),
                        Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
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
        width: AppSize.buttonHeight,
        height: AppSize.buttonHeight,
        child: TextField(
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
