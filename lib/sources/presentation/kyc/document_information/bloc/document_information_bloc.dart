import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../../../core/app_core.dart';

part 'document_information_event.dart';
part 'document_information_state.dart';

class DocumentInfoSuccess extends FormStatus {}

class DocumentInformationBloc extends Bloc<DocumentInformationEvent, DocumentInformationState> {
  final CatalogRepository catalogRepository;
  final UserVerificationRepository userVerificationRepository;
  final UserUtilitiesRepository userUtilitiesRepository;

  DocumentInformationBloc({
    required this.catalogRepository,
    required this.userUtilitiesRepository,
    required this.userVerificationRepository,
  }) : super(DocumentInformationState()) {
    on<GetCatalog>(_getCountryList);

    // on<UploadKycInfo>(_onUploadKycInfo);

    on<DocumentInfoSubscriptionRequested>(_onUserInfoSubscriptionRequested);

    on<IDNumberChanged>((event, emit) {
      emit(state.copyWith(idNumber: event.idNumber));
    });

    on<IdIssueCountrySelected>((event, emit) {
      emit(state.copyWith(idIssueCountry: event.issueCountry));
    });

    on<IDIssueDateSelected>((event, emit) {
      emit(state.copyWith(idIssueDate: event.issueDate));
    });

    on<IDExpiryDateSelected>((event, emit) {
      emit(state.copyWith(idExpiryDate: event.expiryDate));
    });
  }

  _getCountryList(
    GetCatalog event,
    Emitter<DocumentInformationState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await catalogRepository.fetchCountryList(CatalogFilter(language: "en"));
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (countryList) => state.copyWith(idIssueCountryList: countryList, status: InitialStatus()),
      ),
    );
  }

  // void _onUploadKycInfo(UploadKycInfo event, Emitter<DocumentInformationState> emit) async {
  //   final data = UploadUserKycInfo(
  //     city: event.city,
  //     state: event.state,
  //     gender: event.gender,
  //     zipCode: event.zipCode,
  //     lastName: event.lastName,
  //     firstName: event.firstName,
  //     middleName: event.middleName,
  //     idVisaType: event.visaType,
  //     occupation: event.occupation,
  //     nationality: event.nationality,
  //     idIssueDate: state.idIssueDate,
  //     dateOfBirth: event.dateOfBirth,
  //     idExpiryDate: state.idExpiryDate,
  //     documentIdNumber: state.idNumber,
  //     streetAddress: event.streetAddress,
  //     issuedCountry: state.idIssueCountry,
  //     documentIdType: event.documentIdType,
  //     japaneseStreetAddress: event.japaneseStreetAddress,
  //     japaneseSenderAddress: event.japaneseSenderAddress,
  //   );

  //   final response = await userVerificationRepository.uploadCustomerKyc(data);
  //   response.fold((error) {
  //     emit(state.copyWith(
  //       status: SubmissionFailure(error),
  //     ));
  //   }, (code) {});
  // }

  Future<void> _onUserInfoSubscriptionRequested(
    DocumentInfoSubscriptionRequested event,
    Emitter<DocumentInformationState> emit,
  ) async {
    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (userInfo) => userInfo != null
          ? state.copyWith(
              idIssueCountry: userInfo.identificationInfo?.issuedCountry?.id != ""
                  ? Country(
                      id: userInfo.identificationInfo?.issuedCountry?.id ?? "",
                      value: userInfo.identificationInfo?.issuedCountry?.value ?? "")
                  : null,
              idIssueDate: userInfo.identificationInfo?.issuedDate,
              idExpiryDate: userInfo.identificationInfo?.expiryDate,
              idNumber: userInfo.identificationInfo?.idNumber,
              status: DocumentInfoSuccess(),
            )
          : state,
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure));
      },
    );
  }
}
