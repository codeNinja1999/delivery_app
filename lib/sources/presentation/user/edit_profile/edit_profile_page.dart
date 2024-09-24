import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

import 'bloc/edit_profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const MyAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.viewMargin),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            "About you".toUpperCase(),
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "Full Name",
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "Email Address Name",
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "Phone Number",
          ),
          const SizedBox(height: AppSize.viewSpacing),
          Text(
            "Address".toUpperCase(),
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "Address",
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "House Number",
          ),
          const SizedBox(height: AppSize.inset),
          AppTextfield(
            title: "Dropbox Number",
          ),
          const SizedBox(height: AppSize.viewSpacing),
          CustomButton(
              title: "Update",
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ]),
      ),
    );
  }
}

class FirstNameInput extends StatelessWidget {
  const FirstNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return AppTextfield(
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))],
          title: LocaleKeys.fullName.value,
          textCapitalization: TextCapitalization.words,
          placeHolder: LocaleKeys.enterFullName.value,
          textInputType: TextInputType.name,
          validator: (_) => state.firstNameValidation,
          onChanged: (firstName) {
            context.read<EditProfileBloc>().add(FirstNameChanged(firstName));
          },
        );
      },
    );
  }
}

class MiddleNameInput extends StatelessWidget {
  const MiddleNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.middleName != current.middleName,
      builder: (context, state) {
        return AppTextfield(
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))],
          title: "Middle Name",
          textCapitalization: TextCapitalization.words,
          placeHolder: "Enter Middle Name",
          textInputType: TextInputType.name,
          onChanged: (middleName) {
            context.read<EditProfileBloc>().add(MiddleNameChanged(middleName));
          },
        );
      },
    );
  }
}

class LastNameInput extends StatelessWidget {
  const LastNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return AppTextfield(
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))],
          title: "Last Name",
          textCapitalization: TextCapitalization.words,
          placeHolder: "Enter Last Name",
          textInputType: TextInputType.name,
          validator: (_) => state.lastNameValidation,
          onChanged: (lastName) {
            context.read<EditProfileBloc>().add(LastNameChanged(lastName));
          },
        );
      },
    );
  }
}

class UserNameInput extends StatelessWidget {
  const UserNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.userName != current.userName,
      builder: (context, state) {
        return AppTextfield(
          title: "User Name",
          placeHolder: "Enter User Name",
          textInputType: TextInputType.text,
          validator: (_) => state.userNameValidation,
          onChanged: (userName) {
            context.read<EditProfileBloc>().add(UserNameChanged(userName));
          },
        );
      },
    );
  }
}

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return AppTextfield(
          title: "Phone Number",
          textCapitalization: TextCapitalization.none,
          placeHolder: "Enter Phone Number",
          textInputType: TextInputType.phone,
          validator: (_) => state.phoneNumberValidation,
          onChanged: (phoneNumber) {
            context.read<EditProfileBloc>().add(PhoneNumberChanged(phoneNumber));
          },
        );
      },
    );
  }
}

class HouseNumberInput extends StatelessWidget {
  const HouseNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.houseNumber != current.houseNumber,
      builder: (context, state) {
        return AppTextfield(
          title: "House Number",
          textCapitalization: TextCapitalization.none,
          placeHolder: "Enter House Number",
          textInputType: TextInputType.text,
          validator: (_) => state.houseNumberValidation,
          onChanged: (houseNumber) {
            context.read<EditProfileBloc>().add(HouseNumberChanged(houseNumber));
          },
        );
      },
    );
  }
}

class AdditionalInformationInput extends StatelessWidget {
  const AdditionalInformationInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      buildWhen: (previous, current) => previous.additionalInformation != current.additionalInformation,
      builder: (context, state) {
        return AppTextfield(
          title: "Additional Information",
          placeHolder: "Enter Additional Information",
          textInputType: TextInputType.multiline,
          onChanged: (additionalInformation) {
            context.read<EditProfileBloc>().add(AdditionalInformationChanged(additionalInformation));
          },
        );
      },
    );
  }
}