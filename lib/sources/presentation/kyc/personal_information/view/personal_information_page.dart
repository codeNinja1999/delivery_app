import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../../../config/config.dart';
import '../../../../core/app_core.dart';
import '../../../widgets/widgets.dart';
import '../../bloc/kyc_verification_bloc.dart';
import '../../route/route.dart';
import '../bloc/personal_information_bloc.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() => _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  final _formKey = GlobalKey<FormState>();

  final dobDateEditingController = TextEditingController();
  final firstNameEditingController = TextEditingController();
  final middleNameEditingController = TextEditingController();
  final lastNameEditingController = TextEditingController();
  final occupationAlternativeEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<PersonalInformationBloc>();
    bloc.add(FetchCatalog());
    bloc.add(UserInfoSubscriptionRequested());
  }

  @override
  void dispose() {
    super.dispose();
    firstNameEditingController.dispose();
    middleNameEditingController.dispose();
    lastNameEditingController.dispose();
    dobDateEditingController.dispose();
    occupationAlternativeEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.kycVerification.value),
      body: BlocListener<PersonalInformationBloc, PersonalInformationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is Success) {
            firstNameEditingController.text = state.firstName;
            middleNameEditingController.text = state.middleName ?? "";
            lastNameEditingController.text = state.lastName;
            dobDateEditingController.text = state.dateOfBirth;
            occupationAlternativeEditingController.text = state.occupationOther ?? "";
          } else if (status is SubmissionFailure) {
            ErrorResolver.resolve(context, status);
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.inset,
                    vertical: AppSize.viewSpacing,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        LocaleKeys.personalInformation.value,
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: AppSize.inset),
                      Text(
                        LocaleKeys.allProvidedInformationShouldMatchYourId.value,
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: AppSize.viewMargin),
                      _FirstNameInput(firstNameEditingController),
                      const SizedBox(height: AppSize.inset),
                      _MiddleNameInput(middleNameEditingController),
                      const SizedBox(height: AppSize.inset),
                      _LastNameInput(lastNameEditingController),
                      const SizedBox(height: AppSize.inset),
                      const _NationalityInput(),
                      const SizedBox(height: AppSize.viewSpacing),
                      const _GenderInput(),
                      const SizedBox(height: AppSize.viewSpacing),
                      _DateOfBirthInput(dobDateEditingController),
                      const VisaTypeInput(),
                      const SizedBox(height: AppSize.viewSpacing),
                      _OccupationInput(),
                      _OccupationOtherInput(occupationAlternativeEditingController),
                      const SizedBox(height: AppSize.viewSpacing),
                      CustomInformationBox(title: LocaleKeys.whyIsThisNeeded.value),
                    ],
                  ),
                ),
                BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
                  builder: (context, state) {
                    return DividerButton(
                      backTitle: LocaleKeys.cancel.value,
                      nextTitle: LocaleKeys.nextButtonTitle.value,
                      backButtonAction: () => Navigator.of(context).pop(),
                      nextButtonAction: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<KycVerificationBloc>().add(
                                SavePersonalInfo(
                                  firstName: state.firstName,
                                  middleName: state.middleName,
                                  lastName: state.lastName,
                                  nationality: state.nationality,
                                  dateOfBirth: state.dateOfBirth,
                                  occupation: state.occupation,
                                  gender: state.gender,
                                  visaType: state.idVisaType,
                                ),
                              );
                          Navigator.of(context).pushNamed(KycVerificationRoute.currentAddress);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DateOfBirthInput extends StatelessWidget {
  const _DateOfBirthInput(this.dobDateEditingController);
  final TextEditingController dobDateEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
      buildWhen: (previous, current) => previous.dateOfBirth != current.dateOfBirth,
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            final datePicked = await openDatePicker(
                context: context,
                minimumYear: 18,
                date: (state.dateOfBirth != "") ? DateTime.parse(state.dateOfBirth) : null);
            if (datePicked != null) {
              final dobDate = DateFormat('yyyy-MM-dd').format(datePicked);
              if (context.mounted) {
                context.read<PersonalInformationBloc>().add(DateOfBirthSelected(dobDate));
                dobDateEditingController.text = dobDate;
              }
            }
          },
          child: AbsorbPointer(
            child: AppTextfield(
              title: LocaleKeys.dateOfBirth.value,
              placeHolder: LocaleKeys.datePlaceholder.value,
              suffixIcon: const Icon(Icons.calendar_month),
              controller: dobDateEditingController,
              validator: (_) => state.dobValidation,
            ),
          ),
        );
      },
    );
  }
}

class VisaTypeInput extends StatelessWidget {
  const VisaTypeInput({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppSize.inset),
      width: double.infinity,
      child: BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
        buildWhen: (previous, current) =>
            previous.idVisaType != current.idVisaType || previous.idVisaTypeList != current.idVisaTypeList,
        builder: (context, state) {
          return AppDropDown<Catalog>(
            title: "${LocaleKeys.visaTypeTitle.value}*",
            items: state.idVisaTypeList,
            selectedItem: state.idVisaType,
            placeholder: LocaleKeys.visaTypePlaceholder.value,
            onChanged: (visaType) => context.read<PersonalInformationBloc>().add(IdVisaTypeSelected(visaType)),
            validator: (value) {
              return state.idVisaTypeValidation;
            },
          );
        },
      ),
    );
  }
}

class _NationalityInput extends StatelessWidget {
  const _NationalityInput();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
      buildWhen: (previous, current) =>
          previous.nationality != current.nationality || previous.nationalityList != current.nationalityList,
      builder: (context, state) {
        return AppDropDown<Country>(
          title: LocaleKeys.nationalityLabel.value,
          placeholder: LocaleKeys.nationalityPlaceholder.value,
          items: state.nationalityList,
          onChanged: (nationality) {
            context.read<PersonalInformationBloc>().add(NationalitySelected(nationality));
          },
          validator: (_) => state.nationalityValidation,
          selectedItem: state.nationality,
        );
      },
    );
  }
}

class _GenderInput extends StatelessWidget {
  const _GenderInput();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
      buildWhen: (previous, current) => previous.gender != current.gender,
      builder: (context, state) {
        return AppDropDown<Catalog>(
          placeholder: LocaleKeys.genderPlaceholder.value,
          title: LocaleKeys.genderLabel.value,
          items: state.genderList,
          dropdownType: DropdownType.menu,
          validator: (_) => state.genderValidation,
          selectedItem: state.gender,
          enableSearch: false,
          onChanged: (gender) {
            context.read<PersonalInformationBloc>().add(GenderChanged(gender));
          },
          // enabled: isGenderNotEmpty,
        );
      },
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  const _FirstNameInput(this.firstNameController);
  final TextEditingController firstNameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.firstName.value,
          placeHolder: LocaleKeys.firstNamePlaceholder.value,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
          controller: firstNameController,
          textInputType: TextInputType.name,
          onChanged: (firstName) => context.read<PersonalInformationBloc>().add(FirstNameChanged(firstName)),
          validator: (_) => state.firstNameValidation,
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  const _LastNameInput(this.lastNameController);
  final TextEditingController lastNameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.lastName.value,
          placeHolder: LocaleKeys.lastNamePlaceholder.value,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
          textInputType: TextInputType.name,
          controller: lastNameController,
          validator: (_) => state.lastNameValidation,
          onChanged: (lastName) => context.read<PersonalInformationBloc>().add(LastNameChanged(lastName)),
        );
      },
    );
  }
}

class _MiddleNameInput extends StatelessWidget {
  const _MiddleNameInput(this.middleNameController);
  final TextEditingController middleNameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
      buildWhen: (previous, current) => previous.middleName != current.middleName,
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.middleName.value,
          placeHolder: LocaleKeys.middleNamePlaceholder.value,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
          controller: middleNameController,
          textInputType: TextInputType.name,
          onChanged: (middleName) => context.read<PersonalInformationBloc>().add(MiddleNameChanged(middleName)),
        );
      },
    );
  }
}

class _OccupationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
      buildWhen: (previous, current) =>
          previous.occupation != current.occupation || previous.occupationList != current.occupationList,
      builder: (context, state) {
        return AppDropDown<Catalog>(
          title: LocaleKeys.occupationPlaceholder.value,
          items: state.occupationList,
          onChanged: (occupation) => context.read<PersonalInformationBloc>().add(OccupationSelected(occupation)),
          validator: (_) => state.occupationValidation,
          selectedItem: state.occupation,
          placeholder: LocaleKeys.selectOccupation.value,
          enableSearch: true,
        );
      },
    );
  }
}

class _OccupationOtherInput extends StatelessWidget {
  const _OccupationOtherInput(this.occupationAlternativeController);
  final TextEditingController occupationAlternativeController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInformationBloc, PersonalInformationState>(
      buildWhen: (previous, current) =>
          previous.occupation != current.occupation || previous.occupationOther != current.occupationOther,
      builder: (context, state) {
        return (state.occupation?.id == "Others")
            ? Padding(
                padding: const EdgeInsets.only(top: AppSize.inset),
                child: AppTextfield(
                  cornerRadius: AppSize.cornerRadiusSmall,
                  title: LocaleKeys.othersLabel.value,
                  maxLength: 100,
                  controller: occupationAlternativeController,
                  placeHolder: LocaleKeys.othersPlaceholder.value,
                  textInputType: TextInputType.text,
                  validator: (_) => state.occupationOtherValidation,
                  onChanged: (occupationOther) {
                    context.read<PersonalInformationBloc>().add(OccupationOtherSelected(occupationOther));
                  },
                ),
              )
            : Container();
      },
    );
  }
}
