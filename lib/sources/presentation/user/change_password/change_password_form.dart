import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/route/route.dart';

import 'bloc/change_password_bloc.dart';


class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (state.status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          AppRouter.logoutUser(context);
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSize.viewMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CurrentPasswordInput(),
              const SizedBox(height: AppSize.inset),
              const NewPasswordInput(),
              const SizedBox(height: AppSize.inset),
              const ConfirmPasswordInput(),
              const SizedBox(height: AppSize.spacedViewSpacing),
              CustomButton(
                title: LocaleKeys.saveChangesButton.value,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    KeyboardUtil.hideKeyboard(context);
                    showDialog(
                      context: context,
                      builder: (newContext) {
                        return CustomDialog(
                          title: LocaleKeys.changePasswordConfirmation.value,
                          message: LocaleKeys.areYouSureYouWantToChangePassword.value,
                          primaryButtonTitle: LocaleKeys.yes.value,
                          onPrimaryButtonPressed: () => context.read<ChangePasswordBloc>().add(ChangedPassword()),
                          secondaryButtonTitle: LocaleKeys.no.value,
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.confirmPassword.value,
          placeHolder: LocaleKeys.confirmPasswordPlaceholder.value,
          textInputType: TextInputType.text,
          isObscure: true,
          validator: (_) => state.confirmPasswordValidation,
          maxLength: 20,
          onChanged: (confirmPassword) {
            context.read<ChangePasswordBloc>().add(ConfirmPasswordChanged(confirmPassword));
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
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.newPassword.value,
          placeHolder: LocaleKeys.newPasswordPlaceholder.value,
          textInputType: TextInputType.text,
          isObscure: true,
          validator: (_) => state.changePasswordValidation,
          maxLength: 20,
          onChanged: (newPassword) {
            context.read<ChangePasswordBloc>().add(NewPasswordChanged(newPassword));
          },
        );
      },
    );
  }
}

class CurrentPasswordInput extends StatelessWidget {
  const CurrentPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.currentPassword.value,
          placeHolder: LocaleKeys.currentPasswordPlaceholder.value,
          textInputType: TextInputType.text,
          isObscure: true,
          validator: (_) => state.oldPasswordValidation,
          maxLength: 20,
          onChanged: (oldPassword) {
            context.read<ChangePasswordBloc>().add(OldPasswordChanged(oldPassword));
          },
        );
      },
    );
  }
}
