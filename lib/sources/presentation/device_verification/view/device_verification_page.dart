import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/device_verification_bloc.dart';

String strDigits(int n) => n.toString().padLeft(2, '0');

class DeviceVerificationPage extends StatefulWidget {
  const DeviceVerificationPage({super.key});

  @override
  State<DeviceVerificationPage> createState() => _DeviceVerificationPageState();
}

class _DeviceVerificationPageState extends State<DeviceVerificationPage> {
  late ThemeData theme;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: const MyAppBar(),
      body: const DeviceVerifyBody(),
    );
  }
}

class DeviceVerifyBody extends StatefulWidget {
  const DeviceVerifyBody({super.key});

  @override
  DeviceVerifyBodyState createState() => DeviceVerifyBodyState();
}

class DeviceVerifyBodyState extends State<DeviceVerifyBody> {
  var formKey = GlobalKey<FormState>();
  late ThemeData theme;

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    return BlocListener<DeviceVerificationBloc, DeviceVerificationState>(
      listenWhen: (previous, current) {
        if (previous.status is InProgress && current.status is InProgress) {
          return false;
        } else {
          return true;
        }
      },
      listener: (context, state) {
        final status = state.status;
        status is InProgress ? LoadingView.show() : LoadingView.hide();

        if (status is Success) {
          Navigator.of(context).pushNamed(AppRoute.home);
        } else if (status is ResendDeviceVerifyOTPSuccess) {
          SnackbarUtils.showSnackbar(
            context,
            message: LocaleKeys.successfullySendOtp.value,
            icon: Icons.check,
            type: SnackBarType.success,
          );
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: BlocBuilder<DeviceVerificationBloc, DeviceVerificationState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: AppSize.viewMargin,
              right: AppSize.viewMargin,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.inset),
                    child: Text(LocaleKeys.enterSixDigitVerificationCode.value,
                        textAlign: TextAlign.center, style: theme.textTheme.titleLarge),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppSize.inset, bottom: AppSize.spacedViewSpacing),
                    child: Text(
                      LocaleKeys.sendVerificationDescription.value,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.disabledColor,
                      ),
                    ),
                  ),
                  AppTextfield(
                    textInputType: TextInputType.number,
                    placeHolder: LocaleKeys.enterCode.value,
                    validator: (_) => state.verificationCodeValidation,
                    onChanged: (newValue) {
                      context.read<DeviceVerificationBloc>().add(VerificationCodeChanged(newValue));
                    },
                    maxLength: 6,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: AppSize.viewSpacing, bottom: AppSize.viewMargin),
                    child: CustomButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            KeyboardUtil.hideKeyboard(context);
                            context.read<DeviceVerificationBloc>().add(VerifyDevice());
                          }
                        },
                        title: LocaleKeys.confirm.value,
                        buttonType: ButtonType.round),
                  ),
                  const SizedBox(height: AppSize.viewSpacing),
                  (state.resendDuration.inSeconds) >= 0
                      ? Text(
                          "${LocaleKeys.codeCanBeRequested.value}\n${strDigits(state.resendDuration.inMinutes.remainder(60))} : ${strDigits(state.resendDuration.inSeconds.remainder(60))} Minutes",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium)
                      : RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${LocaleKeys.didNotReceiveCode.value}\n\n",
                                style: theme.textTheme.bodyMedium,
                              ),
                              TextSpan(
                                text: LocaleKeys.resendOtp.value,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.indicatorColor,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.normal),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.read<DeviceVerificationBloc>().add(RetryLogin());
                                  },
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
