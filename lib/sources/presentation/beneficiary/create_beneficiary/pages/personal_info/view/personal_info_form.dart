import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/beneficiary_bloc.dart';
import '../../../route/beneficiary_route.dart';
import '../../../widget/fraud_note.dart';
import '../bloc/personal_info_bloc.dart';

class PersonalInfoInfoForm extends StatefulWidget {
  const PersonalInfoInfoForm({super.key});

  @override
  State<PersonalInfoInfoForm> createState() => _PersonalInfoInfoFormState();
}

class _PersonalInfoInfoFormState extends State<PersonalInfoInfoForm> {
  final formKey = GlobalKey<FormState>();

  final relationOtherEditingController = TextEditingController();
  final fullNameEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setPersonalInfo();
  }

  setPersonalInfo() {
    final bloc = context.read<PersonalInfoBloc>();
    final mainState = context.read<BeneficiaryBloc>().state;
    bloc.add(GetCatalog());
    bloc.add(GetReceiverPersonalDetail(mainState.detailedReceiver, mainState.isEdit));
    fullNameEditingController.text = mainState.detailedReceiver?.personalInfo?.fullName ?? "";
    phoneNumberEditingController.text = mainState.detailedReceiver?.personalInfo?.mobile ?? "";
    relationOtherEditingController.text = mainState.detailedReceiver?.personalInfo?.relationAlternative ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    relationOtherEditingController.dispose();
    fullNameEditingController.dispose();
    phoneNumberEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalInfoBloc, PersonalInfoState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          final mainBloc = context.read<BeneficiaryBloc>();
          var blocState = context.read<PersonalInfoBloc>().state;
          mainBloc.add(SavePersonalDetail(blocState.personalData));
          Navigator.pushNamed(context, BeneficiaryRoute.addressInfo);
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSize.viewSpacing,
                  horizontal: AppSize.inset,
                ),
                child: Column(
                  children: [
                    Column(children: [
                      const FraudNotes(),
                      const SizedBox(height: AppSize.inset),
                      _FullNameInput(fullNameEditingController),
                      const SizedBox(height: AppSize.inset),
                      _PhoneNumberInput(phoneNumberEditingController),
                      const SizedBox(height: AppSize.cornerRadiusMedium),
                      _RelationInput(),
                      _RelationOtherInput(relationOtherEditingController),
                      const SizedBox(height: AppSize.inset),
                    ]),
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
                    child: NextButton(formKey: formKey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RelationOtherInput extends StatelessWidget {
  const _RelationOtherInput(this.relationOtherController);

  final TextEditingController relationOtherController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      builder: (context, state) {
        return (state.isRelationOther)
            ? Padding(
                padding: const EdgeInsets.only(top: AppSize.inset),
                child: AppTextfield(
                  title: "Relation Other*",
                  onChanged: (detail) => context.read<PersonalInfoBloc>().add(RelationOtherDetailChanged(detail)),
                  validator: (_) => state.otherRelationValidation,
                  textInputType: TextInputType.text,
                  placeHolder: LocaleKeys.otherDetail.value,
                  controller: relationOtherController,
                ),
              )
            : Container();
      },
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Theme.of(context).disabledColor),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSize.viewSpacing,
            horizontal: AppSize.inset,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    KeyboardUtil.hideKeyboard(context);
                    Navigator.of(context).pop();
                  },
                  title: LocaleKeys.backButtonTitle.value,
                  buttonType: ButtonType.bordered,
                ),
              ),
              const SizedBox(width: AppSize.inset),
              BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
                builder: (context, state) {
                  return Expanded(
                    child: CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          KeyboardUtil.hideKeyboard(context);
                          context.read<PersonalInfoBloc>().add(SaveBeneficiaryPersonalInfo());
                        }
                      },
                      title: LocaleKeys.nextButtonTitle.value,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FullNameInput extends StatelessWidget {
  const _FullNameInput(this.fullNameController);
  final TextEditingController fullNameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) => previous.fullName != current.fullName,
      builder: (context, state) {
        // var codeLength = state.fullName.length;
        return AppTextfield(
          enabled: !(state.isEdit),
          title: "Full name*",
          controller: fullNameController,
          textInputType: TextInputType.name,
          placeHolder: LocaleKeys.enterFullNameOfTheAccountHolder.value,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
          ],
          onChanged: (fullName) {
            context.read<PersonalInfoBloc>().add(FullNameChanged(fullName));
          },
          validator: (_) => state.fullNameValidation,
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput(this.phoneNumberController);
  final TextEditingController phoneNumberController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
      buildWhen: (previous, current) => previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        final phoneNumberTitle = "${LocaleKeys.phoneNumberTitle.value}*";
        final phoneNumberPlaceHolder = LocaleKeys.beneficiaryPhoneNumberPlaceHolder.value;
        return AppTextfield(
          maxLength: 15,
          title: phoneNumberTitle,
          placeHolder: phoneNumberPlaceHolder,
          textInputType: TextInputType.number,
          controller: phoneNumberController,
          validator: (_) => state.phoneNumberValidation,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (phoneNumber) => context.read<PersonalInfoBloc>().add(PhoneNumberChanged(phoneNumber)),
        );
      },
    );
  }
}

class _RelationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController relationOtherEditingController = TextEditingController();
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: double.infinity,
      child: BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
        buildWhen: (previous, current) =>
            previous.relation != current.relation || previous.relationList != current.relationList,
        builder: (context, state) {
          return Column(
            children: [
              AppDropDown<Catalog>(
                cornerRadius: AppSize.cornerRadiusSmall,
                title: LocaleKeys.relationship.value,
                textController: relationOtherEditingController,
                items: state.relationList,
                placeholder: "Select Relationship",
                validator: (_) => state.relationValidation,
                selectedItem: state.relation,
                onChanged: (relation) {
                  context.read<PersonalInfoBloc>().add(RelationSelected(relation));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
