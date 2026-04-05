import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/forgot_password/forgot_password.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

class VerifyEmailForm extends StatefulWidget {
  const VerifyEmailForm({super.key});

  @override
  State<VerifyEmailForm> createState() => _VerifyEmailFormState();
}

class _VerifyEmailFormState extends State<VerifyEmailForm> {
  final formKey = GlobalKey<FormState>();
  final usernameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<VerifyEmailBloc, VerifyEmailState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        status is InProgress ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          final registerBloc = context.read<ForgotPasswordBloc>();
          registerBloc.add(SaveEmail(state.emailAddress));
          Navigator.of(context).pushNamed(ResetPasswordRoute.otpVerify);
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin),
        child: Form(
          key: formKey,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  const SizedBox(height: AppSize.spacedViewSpacing),
                  Text(
                    LocaleKeys.enterEmail.value,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                  const SizedBox(height: AppSize.viewSpacing),
                  const EmailAddressInput(),
                  const SizedBox(height: AppSize.inset * 0.5),
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  const Spacer(),
                  const SizedBox(height: AppSize.viewSpacing),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
                    child: CustomButton(
                      title: LocaleKeys.nextButtonTitle.value,
                      onPressed: () {
                        Navigator.of(context).pushNamed(ResetPasswordRoute.otpVerify);

                        // if (formKey.currentState!.validate()) {
                        //   KeyboardUtil.hideKeyboard(context);
                        //   context.read<VerifyEmailBloc>().add(VerifyEmailAddress());
                        // }
                      },
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EmailAddressInput extends StatelessWidget {
  const EmailAddressInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
      buildWhen: (previous, current) => previous.emailAddress != current.emailAddress,
      builder: (mainContext, state) {
        return AppTextfield(
          title: LocaleKeys.emailAddressTitle.value,
          placeHolder: LocaleKeys.emailAddressPlaceholder.value,
          textInputType: TextInputType.emailAddress,
          validator: (_) => state.emailValidation,
          onChanged: (email) => context.read<VerifyEmailBloc>().add(EmailAddressChanged(email)),
        );
      },
    );
  }
}
