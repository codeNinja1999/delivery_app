import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/existing_member_bloc.dart';
import '../bloc/new_password_bloc.dart';

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({super.key});

  @override
  State<NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewPasswordBloc, NewPasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          _showRegisterSuccessDialog();
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.viewMargin,
          vertical: AppSize.viewSpacing,
        ),
        child: Form(
          key: formKey,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Text(
                    LocaleKeys.setPassword.value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.inset * 2),
                  ),
                  const SizedBox(height: AppSize.viewMargin),
                  const NewPasswordInput(),
                  const SizedBox(height: AppSize.inset),
                  const ConfirmPasswordInput(),
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  const Spacer(),
                  const SizedBox(height: AppSize.viewSpacing),
                  CustomButton(
                      title: LocaleKeys.submit.value,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          KeyboardUtil.hideKeyboard(context);
                          final mainState = context.read<ExistingMemberBloc>().state;
                          context.read<NewPasswordBloc>().add(
                                UpdateExistingMember(
                                  customerProcessId: mainState.existingMemberResult?.customerProcessId,
                                  customerId: mainState.existingMemberResult?.customerId,
                                  profileImage: mainState.selfieImageName,
                                  emailProcessId: mainState.processID,
                                ),
                              );
                        }
                      }),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showRegisterSuccessDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: CustomDialog(
            imageString: AppImages.registeredPhone,
            title: LocaleKeys.welcomeAboardTitle.value,
            message: LocaleKeys.yourAccountHasBeenRegisteredSuccessfully.value,
            primaryButtonTitle: LocaleKeys.logIn.value,
            onPrimaryButtonPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        );
      },
    );
  }
}

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      buildWhen: (previous, current) => previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.confirmPassword.value,
          placeHolder: LocaleKeys.confirmPasswordPlaceholder.value,
          textInputType: TextInputType.text,
          isObscure: true,
          validator: (_) => state.confirmPasswordValidation,
          maxLength: 20,
          onChanged: (confirmPassword) {
            context.read<NewPasswordBloc>().add(ConfirmPasswordChanged(confirmPassword));
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
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      buildWhen: (previous, current) => previous.newPassword != current.newPassword,
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.newPassword.value,
          placeHolder: LocaleKeys.newPasswordPlaceholder.value,
          textInputType: TextInputType.text,
          isObscure: true,
          validator: (_) => state.newPasswordValidation,
          maxLength: 20,
          onChanged: (newPassword) {
            context.read<NewPasswordBloc>().add(NewPasswordChanged(newPassword));
          },
        );
      },
    );
  }
}
