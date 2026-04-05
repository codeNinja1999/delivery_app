import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/sources/route/app_route.dart';

import '../bloc/register_form_bloc.dart';
import '../widgets/password_rule_view.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterFormBloc, RegisterFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          _showSuccessDialog();
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSize.spacedViewSpacing),
                  Text(
                    LocaleKeys.tellUsAboutYourself.value,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.inset * 2),
                  ),
                  const SizedBox(height: AppSize.viewMargin),
                  const FullNameInput(),
                  const SizedBox(height: AppSize.inset),
                  const MobileNumberInput(),
                  const SizedBox(height: AppSize.inset),
                  const PasswordInput(),
                  const SizedBox(height: AppSize.inset),
                  const ConfirmPasswordInput(),
                  const SizedBox(height: AppSize.inset),
                  const PasswordRulView(),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
                      child: CustomButton(
                          title: LocaleKeys.register.value,
                          onPressed: () {
                            _showSuccessDialog(); // KeyboardUtil.hideKeyboard(context);
                            // if (formKey.currentState!.validate()) {
                            // final mainState = context.read<NewMemberBloc>().state;
                            // context.read<RegisterFormBloc>().add(
                            //       RegisterUser(
                            //         username: mainState.userName,
                            //         processId: mainState.registerProcessID,
                            //       ),
                            //     );
                            // }
                          })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (newContext) {
        return PopScope(
          canPop: false,
          child: CustomDialog(
            imageString: AppImages.registeredPhone,
            title: LocaleKeys.registerSuccessful.value,
            message: LocaleKeys.yourAccountHasBeenRegisteredSuccessfully.value,
            primaryButtonTitle: LocaleKeys.logIn.value,
            onPrimaryButtonPressed: () {
              Navigator.of(context, rootNavigator: true).pushReplacementNamed(AppRoute.user);
            },
          ),
        );
      },
    );
  }
}

class FullNameInput extends StatelessWidget {
  const FullNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      buildWhen: (previous, current) => previous.fullName != current.fullName,
      builder: (context, state) {
        return AppTextfield(
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))],
          title: "${LocaleKeys.fullName.value}*",
          textCapitalization: TextCapitalization.words,
          placeHolder: LocaleKeys.enterFullName.value,
          textInputType: TextInputType.name,
          validator: (_) => state.fullNameValidation,
          onChanged: (fullName) {
            context.read<RegisterFormBloc>().add(FullNameChanged(fullName));
          },
        );
      },
    );
  }
}

class MobileNumberInput extends StatelessWidget {
  const MobileNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      buildWhen: (previous, current) => previous.mobileNumber != current.mobileNumber,
      builder: (context, state) {
        return AppTextfield(
          maxLength: 11,
          title: LocaleKeys.phoneNumberTitle.value,
          placeHolder: LocaleKeys.phoneNumberTitle.value,
          validator: (_) => state.phoneNumberValidation,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (mobileNumber) {
            context.read<RegisterFormBloc>().add(MobileChanged(mobileNumber));
          },
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return AppTextfield(
          textInputType: TextInputType.text,
          isObscure: true,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')), // Deny whitespace characters
          ],
          title: LocaleKeys.passwordTitle.value,
          placeHolder: LocaleKeys.enterPassword.value,
          validator: (_) => state.passwordValidation,
          onChanged: (password) {
            context.read<RegisterFormBloc>().add(PasswordChanged(password));
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
    return BlocBuilder<RegisterFormBloc, RegisterFormState>(
      buildWhen: (previous, current) => previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return AppTextfield(
          textInputType: TextInputType.text,
          isObscure: true,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')), // Deny whitespace characters
          ],
          title: LocaleKeys.confirmPassword.value,
          placeHolder: LocaleKeys.confirmPasswordPlaceholder.value,
          validator: (_) => state.confirmPasswordValidation,
          onChanged: (confirmPassword) {
            context.read<RegisterFormBloc>().add(ConfirmPasswordChanged(confirmPassword));
          },
        );
      },
    );
  }
}
