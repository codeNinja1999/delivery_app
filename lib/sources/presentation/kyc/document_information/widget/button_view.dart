import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_core.dart';
import '../../../widgets/widgets.dart';
import '../../kyc_verification.dart';

class ButtonView extends StatelessWidget {
  const ButtonView({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentInformationBloc, DocumentInformationState>(
      builder: (context, state) {
        return DividerButton(
            backTitle: LocaleKeys.back.value,
            nextTitle: LocaleKeys.nextButtonTitle.value,
            backButtonAction: () => Navigator.of(context).pop(),
            nextButtonAction: () {
              if (_formKey.currentState!.validate()) {
                //   final nationality = context.read<KycVerificationBloc>().state.nationality;
                //   final dateOfBirth = context.read<KycVerificationBloc>().state.dateOfBirth;
                //   final firstName = context.read<KycVerificationBloc>().state.firstName;
                //   final lastName = context.read<KycVerificationBloc>().state.lastName;
                //   final middleName = context.read<KycVerificationBloc>().state.middleName;
                //   final state = context.read<KycVerificationBloc>().state.state;
                //   final zipCode = context.read<KycVerificationBloc>().state.zipCode;
                //   final occupation = context.read<KycVerificationBloc>().state.occupation;
                //   final streetAddress = context.read<KycVerificationBloc>().state.streetAddress;
                //   final japaneseStreetAddress = context.read<KycVerificationBloc>().state.japaneseStreetAddress;
                //   final gender = context.read<KycVerificationBloc>().state.gender;
                //   final city = context.read<KycVerificationBloc>().state.city;
                //   final documentType = context.read<KycVerificationBloc>().state.documentType;
                //   final visaType = context.read<KycVerificationBloc>().state.visaType;
                //   final japaneseSenderAddress = context.read<KycVerificationBloc>().state.japaneseSenderAddress;
                //   final mainState = context.read<KycVerificationBloc>().state.verificationInfo;
                //   context.read<DocumentInformationBloc>().add(
                //         UploadKycInfo(
                //           uploadUserKycInfo: mainState,
                //           nationality: nationality,
                //           dateOfBirth: dateOfBirth,
                //           firstName: firstName,
                //           lastName: lastName,
                //           middleName: middleName,
                //           state: state,
                //           occupation: occupation,
                //           streetAddress: streetAddress,
                //           japaneseStreetAddress: japaneseStreetAddress,
                //           japaneseSenderAddress: japaneseSenderAddress,
                //           zipCode: zipCode,
                //           documentIdType: documentType,
                //           city: city,
                //           visaType: visaType,
                //           gender: gender,
                //         ),
                //       );

                context.read<KycVerificationBloc>().add(SaveDocumentInformation(
                      idNumber: state.idNumber,
                      idIssueDate: state.idIssueDate,
                      idExpiryDate: state.idExpiryDate,
                      idIssueCountry: state.idIssueCountry,
                    ));
                Navigator.of(context).pushNamed(KycVerificationRoute.documentFront);
              }
            });
      },
    );
  }
}
