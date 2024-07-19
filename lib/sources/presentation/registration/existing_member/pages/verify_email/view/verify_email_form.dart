import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import '../../../bloc/existing_member_bloc.dart';
import '../../../route/existing_member_route.dart';
import '../bloc/verify_email_bloc.dart';

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
          final registerBloc = context.read<ExistingMemberBloc>();
          registerBloc.add(
            VerificationDetailCollected(
              userName: state.emailAddress,
              processId: state.processID,
            ),
          );
          Navigator.of(context).pushNamed(
            ExistingMemberRoute.verifyOtp,
            arguments: VerifyBy.email,
          );
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: Form(
        key: formKey,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Text(
                    "${LocaleKeys.verifyYourEmailAddress.value}(${LocaleKeys.optional.value})",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: AppSize.inset),
                  EmailAddressInput(usernameEditingController: usernameEditingController),
                  const SizedBox(height: AppSize.cornerRadiusMedium),
                ]),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
                  child: DividerButton(
                    nextTitle: LocaleKeys.nextButtonTitle.value,
                    backTitle: LocaleKeys.skip.value,
                    backButtonAction: () {
                      KeyboardUtil.hideKeyboard(context);
                      Navigator.of(context).pushNamed(ExistingMemberRoute.newPassword, arguments: true);
                    },
                    nextButtonAction: () {
                      if (formKey.currentState!.validate()) {
                        KeyboardUtil.hideKeyboard(context);
                        context.read<VerifyEmailBloc>().add(VerifyNewEmail());
                      }
                    },
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class EmailAddressInput extends StatelessWidget {
  final TextEditingController usernameEditingController;

  const EmailAddressInput({super.key, required this.usernameEditingController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
      buildWhen: (previous, current) => previous.emailAddress != current.emailAddress,
      builder: (context, state) {
        return AppTextfield(
          maxLength: 254,
          controller: usernameEditingController,
          title: LocaleKeys.emailAddressTitle.value,
          placeHolder: LocaleKeys.emailAddressPlaceholder.value,
          textInputType: TextInputType.emailAddress,
          validator: (_) => state.usernameValidation,
          onChanged: (emailAddress) => context.read<VerifyEmailBloc>().add(EmailAddressChanged(emailAddress)),
        );
      },
    );
  }
}
