import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';
import '../../../bloc/existing_member_bloc.dart';
import '../../../route/existing_member_route.dart';
import '../bloc/id_validate_bloc.dart';

class IdValidateForm extends StatefulWidget {
  const IdValidateForm({super.key});

  @override
  State<IdValidateForm> createState() => _IdValidateFormState();
}

class _IdValidateFormState extends State<IdValidateForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<IdValidateBloc, IdValidateState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        final status = state.status;
        (status is InProgress) ? LoadingView.show() : LoadingView.hide();
        if (status is Success) {
          context.read<ExistingMemberBloc>().add(SaveExistingMemberResult(state.checkExistingMemberResult));

          state.autoValidate
              ? (state.checkExistingMemberResult?.status == "Pending")
                  ? _confirmationDialog(context)
                  : Navigator.of(context).pushNamed(ExistingMemberRoute.selfie)
              : Navigator.of(context).pushNamed(ExistingMemberRoute.selfie);
        } else if (status is SubmissionFailure) {
          ErrorResolver.resolve(context, status);
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.viewMargin, vertical: AppSize.viewSpacing),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                LocaleKeys.fillInYourDetails.value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.inset * 2),
              ),
              const SizedBox(height: AppSize.viewMargin),
              const IdTypeInput(),
              const SizedBox(height: AppSize.inset),
              const IdNumberInput(),
              const SizedBox(height: AppSize.inset),
              const DateOfBirthInput(),
              const SizedBox(height: AppSize.viewSpacing),
              const CheckAutoValidate(),
              const SizedBox(height: AppSize.viewSpacing),
              const TransactionDetailView(),
              const SizedBox(height: AppSize.viewSpacing),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return CustomButton(
        title: LocaleKeys.validateTitle.value,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            KeyboardUtil.hideKeyboard(context);
            final mainState = context.read<ExistingMemberBloc>().state;
            context.read<IdValidateBloc>().add(CheckExistingMember(mainState.processID));
          }
        });
  }

  void _confirmationDialog(BuildContext rootContext) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: CustomDialog(
            imageString: AppImages.registeredPhone,
            title: LocaleKeys.confirmationTitle.value,
            message: LocaleKeys.manualVerificationMessage.value,
            primaryButtonTitle: LocaleKeys.yes.value,
            secondaryButtonTitle: LocaleKeys.no.value,
            onPrimaryButtonPressed: () {
              Navigator.of(rootContext).pushNamed(ExistingMemberRoute.selfie);
            },
          ),
        );
      },
    );
  }
}

class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdValidateBloc, IdValidateState>(
      buildWhen: (previous, current) => previous.autoValidate != current.autoValidate,
      builder: (context, state) {
        return state.autoValidate
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TransactionNumberInput(),
                  SizedBox(height: AppSize.inset),
                  TransactionDateInput(),
                  SizedBox(height: AppSize.inset),
                  TransactionAmountInput(),
                ],
              )
            : Container();
      },
    );
  }
}

class CheckAutoValidate extends StatelessWidget {
  const CheckAutoValidate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdValidateBloc, IdValidateState>(
      buildWhen: (previous, current) => previous.autoValidate != current.autoValidate,
      builder: (context, state) {
        return Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            SizedBox(
              height: AppSize.inset * 2,
              width: AppSize.inset * 2,
              child: Checkbox(
                  value: state.autoValidate,
                  onChanged: (value) {
                    context.read<IdValidateBloc>().add(AutoValidateChanged(value));
                  }),
            ),
            Expanded(
              child: Text(
                LocaleKeys.autoValidateMessage.value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        );
      },
    );
  }
}

class IdNumberInput extends StatelessWidget {
  const IdNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdValidateBloc, IdValidateState>(
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.idNumberLabel.value,
          placeHolder: LocaleKeys.idNumberPlaceholder.value,
          validator: (_) => state.idNumberValidation,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))],
          onChanged: (idNumber) {
            context.read<IdValidateBloc>().add(IDNumberChanged(idNumber));
          },
        );
      },
    );
  }
}

class DateOfBirthInput extends StatelessWidget {
  const DateOfBirthInput({super.key});

  @override
  Widget build(BuildContext context) {
    final dobController = TextEditingController();
    return BlocBuilder<IdValidateBloc, IdValidateState>(
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
                context.read<IdValidateBloc>().add(DateOfBirthSelected(dobDate));
                dobController.text = dobDate;
              }
            }
          },
          child: AbsorbPointer(
            child: AppTextfield(
              title: LocaleKeys.dateOfBirth.value,
              placeHolder: LocaleKeys.datePlaceholder.value,
              suffixIcon: const Icon(Icons.calendar_month),
              controller: dobController,
              validator: (_) => state.dobValidation,
            ),
          ),
        );
      },
    );
  }
}

class TransactionDateInput extends StatelessWidget {
  const TransactionDateInput({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionDateController = TextEditingController();
    return BlocBuilder<IdValidateBloc, IdValidateState>(
      buildWhen: (previous, current) => previous.transactionDate != current.transactionDate,
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            final datePicked = await openDatePicker(
                context: context,
                minimumYear: 0,
                date: (state.transactionDate != "") ? DateTime.parse(state.transactionDate) : null);
            if (datePicked != null) {
              final transactionDate = DateFormat('yyyy-MM-dd').format(datePicked);
              if (context.mounted) {
                context.read<IdValidateBloc>().add(TransactionDateSelected(transactionDate));
                transactionDateController.text = transactionDate;
              }
            }
          },
          child: AbsorbPointer(
            child: AppTextfield(
              title: LocaleKeys.transactionDate.value,
              placeHolder: LocaleKeys.transactionDatePlaceholder.value,
              suffixIcon: const Icon(Icons.calendar_month),
              controller: transactionDateController,
              validator: (_) => state.transactionDateValidation,
            ),
          ),
        );
      },
    );
  }
}

class IdTypeInput extends StatelessWidget {
  const IdTypeInput({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppSize.inset),
      width: double.infinity,
      child: BlocBuilder<IdValidateBloc, IdValidateState>(
        buildWhen: (previous, current) => previous.idType != current.idType || previous.idTypeList != current.idTypeList,
        builder: (context, state) {
          return AppDropDown<Catalog>(
            title: "${LocaleKeys.idType.value}*",
            items: state.idTypeList,
            selectedItem: state.idType,
            placeholder: LocaleKeys.idTypePlaceholder.value,
            onChanged: (idType) => context.read<IdValidateBloc>().add(IdTypeSelected(idType)),
            validator: (_) => state.idTypeValidation,
          );
        },
      ),
    );
  }
}

class TransactionNumberInput extends StatelessWidget {
  const TransactionNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdValidateBloc, IdValidateState>(
      buildWhen: (previous, current) => previous.transactionId != current.transactionId,
      builder: (context, state) {
        return AppTextfield(
          textInputType: TextInputType.text,
          title: LocaleKeys.transactionId.value,
          placeHolder: LocaleKeys.transactionIdPlaceholder.value,
          validator: (_) => state.transactionIdValidation,
          onChanged: (transactionId) {
            context.read<IdValidateBloc>().add(TransactionIdChanged(transactionId));
          },
        );
      },
    );
  }
}

class TransactionAmountInput extends StatelessWidget {
  const TransactionAmountInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdValidateBloc, IdValidateState>(
      buildWhen: (previous, current) => previous.transactionAmount != current.transactionAmount,
      builder: (context, state) {
        return AppTextfield(
          textInputType: TextInputType.text,
          title: LocaleKeys.transactionAmount.value,
          placeHolder: LocaleKeys.transactionAmountPlaceholder.value,
          validator: (_) => state.transactionAmountValidation,
          onChanged: (transactionAmount) {
            context.read<IdValidateBloc>().add(TransactionAmountChanged(transactionAmount));
          },
        );
      },
    );
  }
}
