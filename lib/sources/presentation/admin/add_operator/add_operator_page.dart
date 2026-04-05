import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import 'bloc/add_operator_bloc.dart';

class AddOperatorPage extends StatefulWidget {
  const AddOperatorPage({super.key});

  @override
  State<AddOperatorPage> createState() => _AddOperatorPageState();
}

class _AddOperatorPageState extends State<AddOperatorPage> {
  final _formKey = GlobalKey<FormState>();
  final fullNameEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();
  final emailAddressEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AddOperatorBloc>().add(GetOperator());
  }

  @override
  void dispose() {
    super.dispose();
    fullNameEditingController.dispose();
    phoneNumberEditingController.dispose();
    emailAddressEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const MyAppBar(
        title: "Add/Update Operator",
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocListener<AddOperatorBloc, AddOperatorState>(
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is Success) {
            fullNameEditingController.text = state.fullName;
            phoneNumberEditingController.text = state.phoneNumber;
            emailAddressEditingController.text = state.emailAddress;
          }
          if (status is SubmissionFailure) {
            Navigator.of(context).pop();
          }
          if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.viewSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FullNameInput(fullNameController: fullNameEditingController),
                const SizedBox(height: AppSize.inset),
                PhoneNumberInput(phoneNumberController: phoneNumberEditingController),
                const SizedBox(height: AppSize.inset),
                EmailAddressInput(emailAddressController: emailAddressEditingController),
                const SizedBox(height: AppSize.inset),
                const NewPasswordInput(),
                const SizedBox(height: AppSize.inset),
                const ConfirmPasswordInput(),
                const SizedBox(height: AppSize.viewSpacing),
                CustomButton(
                    title: "Save Operator",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AddOperatorBloc>().add(SubmitOperator());
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FullNameInput extends StatelessWidget {
  const FullNameInput({super.key, required this.fullNameController});
  final TextEditingController fullNameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOperatorBloc, AddOperatorState>(
      buildWhen: (previous, current) => previous.fullName != current.fullName,
      builder: (context, state) {
        return AppTextfield(
          title: "Full Name",
          controller: fullNameController,
          textCapitalization: TextCapitalization.words,
          validator: (_) => state.fullNameValidation,
          onChanged: (fullName) {
            context.read<AddOperatorBloc>().add(FullNameChanged(fullName));
          },
        );
      },
    );
  }
}

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({super.key, required this.phoneNumberController});
  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOperatorBloc, AddOperatorState>(
      buildWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return AppTextfield(
          title: "Phone Number",
          controller: phoneNumberController,
          validator: (_) => state.phoneNumberValidation,
          onChanged: (phoneNumber) {
            context.read<AddOperatorBloc>().add(PhoneNumberChanged(phoneNumber: phoneNumber));
          },
        );
      },
    );
  }
}

class EmailAddressInput extends StatelessWidget {
  const EmailAddressInput({super.key, required this.emailAddressController});
  final TextEditingController emailAddressController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOperatorBloc, AddOperatorState>(
      buildWhen: (previous, current) => previous.emailAddress != current.emailAddress,
      builder: (context, state) {
        return AppTextfield(
          title: "Email Address",
          controller: emailAddressController,
          textInputType: TextInputType.emailAddress,
          validator: (_) => state.emailValidation,
          onChanged: (emailAddress) {
            context.read<AddOperatorBloc>().add(EmailAddressChanged(emailAddress));
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
    return BlocBuilder<AddOperatorBloc, AddOperatorState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return AppTextfield(
          title: "New Password",
          validator: (_) => state.passwordValidation,
          onChanged: (password) {
            context.read<AddOperatorBloc>().add(PasswordChanged(password: password));
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
    return BlocBuilder<AddOperatorBloc, AddOperatorState>(
      buildWhen: (previous, current) => previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return AppTextfield(
          title: "Confirm Password",
          validator: (_) => state.confirmPasswordValidation,
          onChanged: (confirmPassword) {
            context.read<AddOperatorBloc>().add(ConfirmPasswordChanged(confirmPassword));
          },
        );
      },
    );
  }
}
