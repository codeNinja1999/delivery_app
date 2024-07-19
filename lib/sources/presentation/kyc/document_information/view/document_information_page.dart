import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/config.dart';
import '../../../../core/app_core.dart';
import '../../../widgets/widgets.dart';
import '../../kyc_verification.dart';
import '../document_information.dart';

class DocumentInformationPage extends StatefulWidget {
  const DocumentInformationPage({super.key});

  @override
  State<DocumentInformationPage> createState() => _DocumentInformationPageState();
}

class _DocumentInformationPageState extends State<DocumentInformationPage> {
  final _formKey = GlobalKey<FormState>();
  final idNumberEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<DocumentInformationBloc>();
    bloc.add(GetCatalog());
    bloc.add(DocumentInfoSubscriptionRequested());
  }

  @override
  void dispose() {
    super.dispose();
    idNumberEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: MyAppBar(title: LocaleKeys.kycVerification.value),
      body: BlocListener<DocumentInformationBloc, DocumentInformationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          final status = state.status;
          (status is InProgress) ? LoadingView.show() : LoadingView.hide();
          if (status is DocumentInfoSuccess) {
            idNumberEditingController.text = state.idNumber ?? "";
          } else if (status is Success) {
            context.read<KycVerificationBloc>().add(
                  SaveDocumentInformation(
                    idExpiryDate: state.idExpiryDate,
                    idIssueDate: state.idIssueDate,
                    idIssueCountry: state.idIssueCountry,
                    idNumber: state.idNumber,
                  ),
                );
            Navigator.of(context).pushNamed(KycVerificationRoute.documentFront);
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
                    horizontal: AppSize.viewMargin,
                    vertical: AppSize.viewSpacing,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        LocaleKeys.documentInformation.value,
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: AppSize.inset),
                      Text(
                        LocaleKeys.fillIdInformation.value,
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: AppSize.viewMargin),
                      const IssuedCountryInput(),
                      const SizedBox(height: AppSize.inset),
                      _IdNumberInput(idNumberEditingController),
                      const SizedBox(height: AppSize.inset),
                      const _IssueDateInput(),
                      const SizedBox(height: AppSize.inset),
                      const _ExpiryDateInput(),
                      const SizedBox(height: AppSize.cornerRadiusMedium),
                      const SizedBox(height: AppSize.cornerRadiusMedium),
                    ],
                  ),
                ),
                ButtonView(formKey: _formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExpiryDateInput extends StatelessWidget {
  const _ExpiryDateInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentInformationBloc, DocumentInformationState>(
      buildWhen: (previous, current) => previous.idExpiryDate != current.idExpiryDate,
      builder: (context, state) {
        final bloc = context.read<DocumentInformationBloc>();
        return GestureDetector(
          onDoubleTap: null,
          onTap: () async {
            final datePicked = await openDatePicker(context: context, minimumYear: null);
            if (datePicked != null) {
              final date = DateFormat('yyyy/MM/dd').format(datePicked);
              if (context.mounted) {
                bloc.add(IDExpiryDateSelected(date));
              }
            }
          },
          child: AppTextfield(
            enabled: false,
            title: LocaleKeys.expiryDatePlaceholder.value,
            placeHolder: LocaleKeys.datePlaceholder.value,
            suffixIcon: const Icon(Icons.calendar_month),
            controller: TextEditingController()..text = state.idExpiryDate ?? "",
            textInputType: TextInputType.text,
            validator: (_) => state.idExpiryDateValidation,
          ),
        );
      },
    );
  }
}

class _IssueDateInput extends StatelessWidget {
  const _IssueDateInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentInformationBloc, DocumentInformationState>(
      builder: (context, state) {
        final bloc = context.read<DocumentInformationBloc>();
        return GestureDetector(
          onDoubleTap: null,
          onTap: () async {
            final datePicked = await openDatePicker(context: context, minimumYear: 0);
            if (datePicked != null) {
              final date = DateFormat('yyyy/MM/dd').format(datePicked);
              if (context.mounted) {
                bloc.add(IDIssueDateSelected(date));
              }
            }
          },
          child: AppTextfield(
            enabled: false,
            title: LocaleKeys.issueDatePlaceholder.value,
            placeHolder: LocaleKeys.datePlaceholder.value,
            suffixIcon: const Icon(Icons.calendar_month),
            controller: TextEditingController()..text = state.idIssueDate ?? "",
            textInputType: TextInputType.text,
            validator: (_) => state.idIssueDateValidation,
          ),
        );
      },
    );
  }
}

class _IdNumberInput extends StatelessWidget {
  const _IdNumberInput(this.idNumberController);
  final TextEditingController idNumberController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentInformationBloc, DocumentInformationState>(
      builder: (context, state) {
        return AppTextfield(
          title: LocaleKeys.idNumberLabel.value,
          placeHolder: LocaleKeys.idNumberPlaceholder.value,
          controller: idNumberController,
          validator: (_) => state.idNumberValidation,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))],
          onChanged: (idNumber) {
            context.read<DocumentInformationBloc>().add(IDNumberChanged(idNumber));
          },
        );
      },
    );
  }
}

class IssuedCountryInput extends StatelessWidget {
  const IssuedCountryInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentInformationBloc, DocumentInformationState>(
      builder: (context, state) {
        return AppDropDown(
          title: LocaleKeys.issuedCountry.value,
          placeholder: LocaleKeys.countryPlaceholder.value,
          items: state.idIssueCountryList,
          onChanged: (issueCountry) {
            context.read<DocumentInformationBloc>().add(IdIssueCountrySelected(issueCountry));
          },
          enableSearch: true,
          selectedItem: state.idIssueCountry,
          validator: (value) {
            return state.idIssueCountryValidation;
          },
        );
      },
    );
  }
}
