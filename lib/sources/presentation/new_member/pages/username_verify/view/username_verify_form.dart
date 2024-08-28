import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import '../../../bloc/new_member_bloc.dart';
import '../../../route/new_member_route.dart';
import '../bloc/username_verify_bloc.dart';

class UsernameVerifyForm extends StatefulWidget {
  const UsernameVerifyForm({super.key});

  @override
  State<UsernameVerifyForm> createState() => _UsernameVerifyFormState();
}

class _UsernameVerifyFormState extends State<UsernameVerifyForm> {
  final formKey = GlobalKey<FormState>();
  final usernameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<UsernameVerifyBloc, UsernameVerifyState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        status is InProgress ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          final registerBloc = context.read<NewMemberBloc>();
          registerBloc.add(VerificationDetailCollected(emailAddress: state.emailAddress));
          Navigator.of(context).pushNamed(NewMemberRoute.otpVerify);
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
                  const SizedBox(height: AppSize.viewMargin),
                  Text(
                    LocaleKeys.signUp.value,
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
                        if (formKey.currentState!.validate()) {
                          KeyboardUtil.hideKeyboard(context);
                          context.read<UsernameVerifyBloc>().add(VerifyEmailAddress());
                        }
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
    return BlocBuilder<UsernameVerifyBloc, UsernameVerifyState>(
      buildWhen: (previous, current) => previous.emailAddress != current.emailAddress,
      builder: (mainContext, state) {
        return AppTextfield(
          title: LocaleKeys.emailAddressTitle.value,
          placeHolder: LocaleKeys.emailAddressPlaceholder.value,
          textInputType: TextInputType.emailAddress,
          validator: (_) => state.emailValidation,
          onChanged: (email) => context.read<UsernameVerifyBloc>().add(EmailAddressChanged(email)),
        );
      },
    );
  }
}
