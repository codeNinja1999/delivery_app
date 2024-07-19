import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
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
          registerBloc.add(
            VerificationDetailCollected(
              userName: state.userId,
              processId: state.processID,
              isEmail: state.isEmail,
            ),
          );
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
                  Text(
                    LocaleKeys.createAccount.value,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 36),
                  ),
                  const SizedBox(height: AppSize.inset),
                  UserIdInput(usernameEditingController: usernameEditingController),
                  const SizedBox(height: AppSize.inset * 0.5),
                  IdToggle(usernameEditingController: usernameEditingController),
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  const Spacer(),
                  const SizedBox(height: AppSize.viewSpacing),
                  const TermLabel(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppSize.viewSpacing),
                    child: CustomButton(
                      title: LocaleKeys.nextButtonTitle.value,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          KeyboardUtil.hideKeyboard(context);
                          context.read<UsernameVerifyBloc>().add(VerifyUserID());
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

class IdToggle extends StatelessWidget {
  final TextEditingController usernameEditingController;

  const IdToggle({super.key, required this.usernameEditingController});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<UsernameVerifyBloc, UsernameVerifyState>(
      buildWhen: (previous, current) => previous.isEmail != current.isEmail,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<UsernameVerifyBloc>().add(IsEmailType(!state.isEmail));
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

class UserIdInput extends StatelessWidget {
  final TextEditingController usernameEditingController;

  const UserIdInput({super.key, required this.usernameEditingController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsernameVerifyBloc, UsernameVerifyState>(
      buildWhen: (previous, current) => previous.isEmail != current.isEmail || previous.userId != current.userId,
      builder: (mainContext, state) {
        final isEmailVerification = state.isEmail;
        final prefixIcon = isEmailVerification
            ? null
            : const Padding(
                padding: EdgeInsets.only(top: 14, left: 14),
                child: Text(AppConstants.senderDialingCode),
              );
        final title = isEmailVerification ? LocaleKeys.emailAddressTitle.value : LocaleKeys.phoneNumberTitle.value;
        final placeholder =
            isEmailVerification ? LocaleKeys.emailAddressPlaceholder.value : LocaleKeys.phoneNumberPlaceholder.value;
        final textInputType = isEmailVerification ? TextInputType.emailAddress : TextInputType.number;
        final inputFormatter = isEmailVerification ? null : [FilteringTextInputFormatter.digitsOnly];
        final maxLength = isEmailVerification ? 254 : 11;

        return AppTextfield(
          maxLength: maxLength,
          prefixIcon: prefixIcon,
          controller: usernameEditingController,
          title: title,
          placeHolder: placeholder,
          textInputType: textInputType,
          inputFormatters: inputFormatter,
          validator: (_) => state.usernameValidation,
          onChanged: (userId) => context.read<UsernameVerifyBloc>().add(UserIdChanged(userId)),
        );
      },
    );
  }
}

class TermLabel extends StatelessWidget {
  const TermLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RichText(
      overflow: TextOverflow.visible,
      text: TextSpan(
        text: LocaleKeys.byRegisteringYouAreAgreeingToAcceptOur.value,
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            style: theme.textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline, color: theme.primaryColor),
            text: LocaleKeys.termsCondition.value,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  AppRoute.userAgreement,
                  arguments: LocaleKeys.termsCondition.value,
                );
              },
          ),
          TextSpan(text: " ${LocaleKeys.and.value} "),
          TextSpan(
            style: theme.textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline, color: theme.primaryColor),
            text: LocaleKeys.privacyPolicy.value,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                  AppRoute.userAgreement,
                  arguments: LocaleKeys.privacyPolicy.value,
                );
              },
          ),
        ],
      ),
    );
  }
}
