import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../bloc/reset_password_bloc.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();

    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        status is InProgress ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          showSuccessDialog(context);
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
                padding: const EdgeInsets.symmetric(horizontal: AppSize.inset),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSize.spacedViewSpacing),
                    Text(LocaleKeys.resetPassword.value, style: theme.textTheme.titleMedium?.copyWith(fontSize: 36)),
                    const SizedBox(height: AppSize.viewMargin),
                    const NewPasswordInput(),
                    const SizedBox(height: AppSize.inset),
                    const ConfirmPasswordInput(),
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
                    child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                      buildWhen: (previous, current) => previous.confirmPassword != current.confirmPassword,
                      builder: (context, state) {
                        return DividerButton(
                          nextTitle: LocaleKeys.resetPassword.value,
                          nextButtonAction: () {
                            KeyboardUtil.hideKeyboard(context);
                            showSuccessDialog(context);
                            // if (formKey.currentState!.validate()) {
                            //   context.read<ResetPasswordBloc>().add(
                            //         SetPassword(
                            //           processID: context.read<ForgotPasswordBloc>().state.resetProcessID,
                            //           confirmPassword: state.confirmPassword,
                            //         ),
                            //       );
                            // }
                          },
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

  void showSuccessDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          imageString: AppImages.resetSuccess,
          title: LocaleKeys.resetSuccessful.value,
          message: LocaleKeys.resetSuccessfulMessage.value,
          primaryButtonTitle: LocaleKeys.login.value,
          onPrimaryButtonPressed: () {
            Navigator.of(context, rootNavigator: true).pushNamed(AppRoute.user);
          },
        );
      },
    );
  }
}

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.confirmPassword.value,
          placeHolder: LocaleKeys.confirmPasswordPlaceholder.value,
          isObscure: true,
          validator: (_) => state.confirmPasswordValidation,
          onChanged: (value) {
            context.read<ResetPasswordBloc>().add(ConfirmPasswordChanged(value));
          },
        );
      },
    );
  }
}

class NewPasswordInput extends StatelessWidget {
  const NewPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      buildWhen: (previous, current) => previous.newPassword != current.newPassword,
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.newPassword.value,
          placeHolder: LocaleKeys.newPasswordPlaceholder.value,
          isObscure: true,
          validator: (_) => state.changePasswordValidation,
          onChanged: (value) {
            context.read<ResetPasswordBloc>().add(NewPasswordChanged(value));
          },
        );
      },
    );
  }
}
