import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import '../../../bloc/existing_member_bloc.dart';
import '../../../route/existing_member_route.dart';
import '../bloc/verify_otp_bloc.dart';

class VerifyOtpForm extends StatefulWidget {
  const VerifyOtpForm({super.key});

  @override
  State<VerifyOtpForm> createState() => _VerifyOtpFormState();
}

class _VerifyOtpFormState extends State<VerifyOtpForm> {
  var formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  final dataKey = GlobalKey();

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

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

    return BlocListener<VerifyOtpBloc, VerifyOtpState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        final mainBloc = context.read<ExistingMemberBloc>();
        status is InProgress ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          mainBloc.add(SaveProcessID(state.processID ?? ""));
          Navigator.pushReplacementNamed(
            context,
            state.verificationType == VerifyBy.mobileNumber ? ExistingMemberRoute.validate : ExistingMemberRoute.newPassword,
          );
        } else if (status is ResendRegisterOTPSuccess) {
          SnackbarUtils.showSnackbar(
            context,
            message: (mainBloc.state.verificationProcessID != "primary")
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
        padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin),
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<ExistingMemberBloc, ExistingMemberState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(top: AppSize.inset),
                          child: Text(
                            state.verificationProcessID != "primary"
                                ? LocaleKeys.verifyYourEmailAddress.value
                                : LocaleKeys.verifyYourPhone.value,
                            style: theme.textTheme.titleMedium?.copyWith(fontSize: 36, height: 1),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSize.spacedViewSpacing),
                    Text(LocaleKeys.verificationCode.value, style: theme.textTheme.bodyLarge),
                    const SizedBox(height: AppSize.viewSpacing),
                    PinputExample(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RegisterOtpInput(
                          first: true,
                          last: false,
                          controller: _fieldOne,
                        ),
                        RegisterOtpInput(
                          first: false,
                          last: false,
                          controller: _fieldTwo,
                        ),
                        RegisterOtpInput(
                          first: false,
                          last: false,
                          controller: _fieldThree,
                        ),
                        RegisterOtpInput(
                          first: false,
                          last: false,
                          controller: _fieldFour,
                        ),
                        RegisterOtpInput(
                          first: false,
                          last: false,
                          controller: _fieldFive,
                        ),
                        RegisterOtpInput(
                          first: false,
                          last: true,
                          controller: _fieldSix,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.cornerRadiusMedium),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
                  buildWhen: (previous, current) => previous.resendDuration != current.resendDuration,
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
                                          final mainState = context.read<ExistingMemberBloc>().state;
                                          context.read<VerifyOtpBloc>().add(
                                                ResendOtp(recipient: mainState.userName),
                                              );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                        VerifyOtpButton(
                          fieldOne: _fieldOne,
                          fieldTwo: _fieldTwo,
                          fieldThree: _fieldThree,
                          fieldFour: _fieldFour,
                          fieldFive: _fieldFive,
                          fieldSix: _fieldSix,
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

class VerifyOtpButton extends StatelessWidget {
  const VerifyOtpButton({
    super.key,
    required TextEditingController fieldOne,
    required TextEditingController fieldTwo,
    required TextEditingController fieldThree,
    required TextEditingController fieldFour,
    required TextEditingController fieldFive,
    required TextEditingController fieldSix,
  })  : _fieldOne = fieldOne,
        _fieldTwo = fieldTwo,
        _fieldThree = fieldThree,
        _fieldFour = fieldFour,
        _fieldFive = fieldFive,
        _fieldSix = fieldSix;

  final TextEditingController _fieldOne;
  final TextEditingController _fieldTwo;
  final TextEditingController _fieldThree;
  final TextEditingController _fieldFour;
  final TextEditingController _fieldFive;
  final TextEditingController _fieldSix;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
      buildWhen: (previous, current) => previous.processID != current.processID,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
          child: CustomButton(
            title: LocaleKeys.nextButtonTitle.value,
            onPressed: () {
              KeyboardUtil.hideKeyboard(context);
              if (_fieldOne.text != "" &&
                  _fieldTwo.text != "" &&
                  _fieldThree.text != "" &&
                  _fieldFour.text != "" &&
                  _fieldFive.text != "" &&
                  _fieldSix.text != "") {
                var otpCode =
                    _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text + _fieldFive.text + _fieldSix.text;
                final mainState = context.read<ExistingMemberBloc>().state;
                context.read<VerifyOtpBloc>().add(
                      VerifyNewAccountOTP(
                        processID: state.processID ?? mainState.verificationProcessID,
                        verificationCode: otpCode,
                      ),
                    );
              }
            },
          ),
        );
      },
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

class PinputExample extends StatefulWidget {
  const PinputExample({Key? key}) : super(key: key);

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child: Pinput(
              // You can pass your own SmsRetriever implementation based on any package
              // in this example we are using the SmartAuth
              length: 4,
              controller: pinController,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              validator: (value) {
                return value == '2222' ? null : 'Pin is incorrect';
              },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              focusNode.unfocus();
              formKey.currentState!.validate();
            },
            child: const Text('Validate'),
          ),
        ],
      ),
    );
  }
}
