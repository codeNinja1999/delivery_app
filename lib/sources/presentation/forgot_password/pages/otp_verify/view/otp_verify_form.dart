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

class OtpVerifyForm extends StatefulWidget {
  const OtpVerifyForm({super.key});

  @override
  State<OtpVerifyForm> createState() => _OtpVerifyFormState();
}

class _OtpVerifyFormState extends State<OtpVerifyForm> {
  var formKey = GlobalKey<FormState>();

  String strDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final emailAddress = context.read<ForgotPasswordBloc>().state.emailAddress;

    return BlocListener<OtpVerifyBloc, OtpVerifyState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        status is InProgress ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          Navigator.of(context).pushReplacementNamed(ResetPasswordRoute.resetPassword);
        } else if (status is ResendResetOTPSuccess) {
          SnackbarUtils.showSnackbar(
            context,
            message: LocaleKeys.successfullySendOtpToYourEmail.value,
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
                    Text(LocaleKeys.verificationCodeSentMessage.tr(args: [emailAddress]), style: theme.textTheme.bodyLarge),
                    const SizedBox(height: AppSize.viewSpacing),
                    PinputExample(
                      onChanged: (pin) => context.read<OtpVerifyBloc>().add(VerificationCodeChanged(pin)),
                    ),
                    const SizedBox(height: AppSize.inset),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(),
                    const SizedBox(height: AppSize.spacedViewSpacing),
                    BlocBuilder<OtpVerifyBloc, OtpVerifyState>(
                      buildWhen: (previous, current) => previous.resendDuration != current.resendDuration,
                      builder: (context, state) {
                        return (state.resendDuration.inSeconds) >= 0
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
                                          final emailAddress = context.read<ForgotPasswordBloc>().state.emailAddress;
                                          context.read<OtpVerifyBloc>().add(ResendOtp(emailAddress));
                                        },
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
                      child: CustomButton(
                        title: LocaleKeys.nextButtonTitle.value,
                        onPressed: () {
                          KeyboardUtil.hideKeyboard(context);
                          context.read<OtpVerifyBloc>().add(VerifyResetOTP());
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
