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
            context.read<ForgotPasswordBloc>().add(SaveEmail(email: state.email));
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
                      const EmailIdInput(),
                      const SizedBox(height: AppSize.inset),
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

class EmailIdInput extends StatelessWidget {
  const EmailIdInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyUserIdBloc, VerifyUserIdState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (mainContext, state) {
        return AppTextfield(
          maxLength: 254,
          title: LocaleKeys.emailAddressTitle.value,
          placeHolder: LocaleKeys.emailAddressPlaceholder.value,
          textInputType: TextInputType.emailAddress,
          validator: (_) => state.loginIdValidation,
          onChanged: (email) {
            context.read<VerifyUserIdBloc>().add(EmailChanged(email));
          },
        );
      },
    );
  }
}
