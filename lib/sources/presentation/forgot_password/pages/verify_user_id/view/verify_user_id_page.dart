import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/forgot_password_bloc.dart';
import '../../../route/reset_password_route.dart';
import '../bloc/verify_user_id_bloc.dart';

class VerifyUserIdPage extends StatefulWidget {
  const VerifyUserIdPage({super.key});

  @override
  State<VerifyUserIdPage> createState() => _VerifyUserIdPageState();
}

class _VerifyUserIdPageState extends State<VerifyUserIdPage> {
  final formKey = GlobalKey<FormState>();
  final usernameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(backButtonAction: () => Navigator.of(context, rootNavigator: true).pop()),
      body: BlocListener<VerifyUserIdBloc, VerifyUserIdState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is Success) {
            context.read<ForgotPasswordBloc>().add(
                  SaveResetOTPVerifyDetails(
                    loginId: state.userId,
                    processId: state.processID,
                    isEmail: state.isEmail,
                  ),
                );
            Navigator.pushNamed(context, ResetPasswordRoute.otpVerify);
          }
          if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: AppSize.viewMargin, right: AppSize.viewMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSize.spacedViewSpacing),
                      Text(
                        LocaleKeys.forgotPassword.value,
                        style: theme.textTheme.titleMedium?.copyWith(fontSize: 36),
                      ),
                      const SizedBox(height: AppSize.inset),
                      LoginIdInput(usernameEditingController: usernameEditingController),
                      const SizedBox(height: AppSize.inset),
                      // IdToggle(usernameEditingController: usernameEditingController),
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
                      padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
                      child: DividerButton(
                        nextTitle: LocaleKeys.getVerificationCode.value,
                        nextButtonAction: () {
                          Navigator.pushNamed(context, ResetPasswordRoute.otpVerify);

                          // if (formKey.currentState!.validate()) {
                          //   KeyboardUtil.hideKeyboard(context);
                          //   context.read<VerifyUserIdBloc>().add(VerifyLoginId());
                          //   // state.email
                          // }
                        },
                      ),
                    ),
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

class LoginIdInput extends StatefulWidget {
  const LoginIdInput({super.key, required this.usernameEditingController});
  final TextEditingController usernameEditingController;

  @override
  State<LoginIdInput> createState() => _LoginIdInputState();
}

class _LoginIdInputState extends State<LoginIdInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyUserIdBloc, VerifyUserIdState>(
      buildWhen: (previous, current) => previous.userId != current.userId || previous.isEmail != current.isEmail,
      builder: (mainContext, state) {
        final prefixIcon = !state.isEmail
            ? const Padding(
                padding: EdgeInsets.only(top: 14, left: 14),
                child: Text(AppConstants.senderDialingCode),
              )
            : null;
        return AppTextfield(
          maxLength: state.isEmail ? 254 : 11,
          prefixIcon: prefixIcon,
          title: state.isEmail ? LocaleKeys.emailAddressTitle.value : LocaleKeys.phoneNumberTitle.value,
          placeHolder: state.isEmail ? LocaleKeys.emailAddressPlaceholder.value : LocaleKeys.phoneNumberPlaceholder.value,
          textInputType: state.isEmail ? TextInputType.emailAddress : TextInputType.number,
          inputFormatters: state.isEmail ? null : [FilteringTextInputFormatter.digitsOnly],
          validator: (_) => state.loginIdValidation,
          onChanged: (loginId) {
            context.read<VerifyUserIdBloc>().add(UserIdChanged(loginId));
          },
        );
      },
    );
  }
}

//843087464

class IdToggle extends StatelessWidget {
  final TextEditingController usernameEditingController;

  const IdToggle({super.key, required this.usernameEditingController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<VerifyUserIdBloc, VerifyUserIdState>(
      buildWhen: (previous, current) => previous.isEmail != current.isEmail,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<VerifyUserIdBloc>().add(IsEmailType(!state.isEmail));
            Form.of(context).reset();
            usernameEditingController.clear();
          },
          child: Text(
            state.isEmail ? LocaleKeys.usePhoneNumberInstead.value : LocaleKeys.useEmailAddressInstead.value,
            style: theme.textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.underline,
              color: theme.primaryColor,
            ),
          ),
        );
      },
    );
  }
}
