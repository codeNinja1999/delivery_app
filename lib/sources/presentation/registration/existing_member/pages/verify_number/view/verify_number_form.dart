import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/route/route.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/existing_member_bloc.dart';
import '../../../route/existing_member_route.dart';
import '../bloc/verify_number_bloc.dart';

class VerifyNumberForm extends StatefulWidget {
  const VerifyNumberForm({super.key});

  @override
  State<VerifyNumberForm> createState() => _VerifyNumberFormState();
}

class _VerifyNumberFormState extends State<VerifyNumberForm> {
  final formKey = GlobalKey<FormState>();
  final usernameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<VerifyNumberBloc, VerifyNumberState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        status is InProgress ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          final registerBloc = context.read<ExistingMemberBloc>();
          registerBloc.add(
            VerificationDetailCollected(
              userName: state.userId,
              processId: state.processID,
            ),
          );
          Navigator.of(context).pushNamed(ExistingMemberRoute.verifyOtp);
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
                    LocaleKeys.createExistingAccount.value,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: AppSize.inset),
                  UserIdInput(usernameEditingController: usernameEditingController),
                  const SizedBox(height: AppSize.inset * 0.5),
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
                          context.read<VerifyNumberBloc>().add(VerifyUserID());
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

class UserIdInput extends StatelessWidget {
  final TextEditingController usernameEditingController;

  const UserIdInput({super.key, required this.usernameEditingController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyNumberBloc, VerifyNumberState>(
      buildWhen: (previous, current) => previous.userId != current.userId,
      builder: (mainContext, state) {
        return AppTextfield(
          maxLength: 11,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(top: 14, left: 14),
            child: Text(AppConstants.senderDialingCode),
          ),
          controller: usernameEditingController,
          title: LocaleKeys.phoneNumberTitle.value,
          placeHolder: LocaleKeys.phoneNumberPlaceholder.value,
          textInputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (_) => state.usernameValidation,
          onChanged: (userId) => context.read<VerifyNumberBloc>().add(UserIdChanged(userId)),
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
