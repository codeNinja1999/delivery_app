import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../../../core/app_core.dart';

part 'personal_information_event.dart';
part 'personal_information_state.dart';

class PersonalInformationBloc extends Bloc<PersonalInformationEvent, PersonalInformationState> {
  final CatalogRepository catalogRepository;
  final UserUtilitiesRepository userUtilitiesRepository;

  PersonalInformationBloc({required this.catalogRepository, required this.userUtilitiesRepository})
      : super(PersonalInformationState()) {
    on<FetchCatalog>((event, emit) async {
      await Future.wait([
        _onGetNationality(event, emit),
        _onGetOccupation(event, emit),
        _onGetVisaType(event, emit),
      ]);
    });
    on<UserInfoSubscriptionRequested>(_onUserInfoSubscriptionRequested);
    on<SetPersonalInfo>(_onSetPersonalDetails);

    on<FirstNameChanged>((event, emit) {
      emit(state.copyWith(firstName: event.firstName));
    });

    on<MiddleNameChanged>((event, emit) {
      final newState = state.copyWith(middleName: event.middleName);
      emit(newState);
    });

    on<LastNameChanged>((event, emit) {
      final newState = state.copyWith(lastName: event.lastName);
      emit(newState);
    });

    on<DateOfBirthSelected>((event, emit) {
      emit(state.copyWith(dateOfBirth: event.dateOfBirth));
    });
    on<GenderChanged>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });

    on<NationalitySelected>((event, emit) {
      final newState = state.copyWith(nationality: event.nationality);
      emit(newState);
    });

    on<OccupationSelected>((event, emit) {
      emit(state.copyWith(occupation: event.occupation, occupationOther: ""));
    });

    on<OccupationOtherSelected>((event, emit) {
      emit(state.copyWith(occupationOther: event.occupationOther));
    });

    on<IdVisaTypeSelected>((event, emit) {
      emit(state.copyWith(idVisaType: event.idVisaType));
    });
  }

  Future<void> _onUserInfoSubscriptionRequested(
    UserInfoSubscriptionRequested event,
    Emitter<PersonalInformationState> emit,
  ) async {
    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (userInfo) => userInfo != null
          ? state.copyWith(
              firstName: userInfo.personalInfo.nameEnglish?.firstName,
              middleName:
                  userInfo.personalInfo.nameEnglish?.middleName == "" ? null : userInfo.personalInfo.nameEnglish?.middleName,
              lastName: userInfo.personalInfo.nameEnglish?.lastName,
              dateOfBirth: userInfo.personalInfo.dateOfBirth,
              gender: (userInfo.personalInfo.gender?.id != "") ? userInfo.personalInfo.gender : null,
              occupation: (userInfo.personalInfo.occupation?.id != "") ? userInfo.personalInfo.occupation : null,
              occupationOther: userInfo.personalInfo.occupationAlternative,
              nationality: (userInfo.personalInfo.nationality?.id != "")
                  ? Country(
                      id: userInfo.personalInfo.nationality?.id ?? "",
                      value: userInfo.personalInfo.nationality?.value ?? "",
                    )
                  : null,
              idVisaType: (userInfo.personalInfo.visaType?.id != "") ? userInfo.personalInfo.visaType : null,
              status: Success(),
            )
          : state,
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure));
      },
    );
  }

  Future<bool> _onGetNationality(
    PersonalInformationEvent event,
    Emitter<PersonalInformationState> emit,
  ) async {
    final response = await catalogRepository.fetchCountryList(CatalogFilter(language: "en"));
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error)),
      (nationalityList) => state.copyWith(nationalityList: nationalityList),
    ));
    return true;
  }

  Future<bool> _onGetOccupation(
    PersonalInformationEvent event,
    Emitter<PersonalInformationState> emit,
  ) async {
    final response = await catalogRepository.fetchOccupationList(CatalogFilter(language: "en"));
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error)),
      (occupationList) => state.copyWith(occupationList: occupationList),
    ));
    return true;
  }

  Future<bool> _onGetVisaType(
    FetchCatalog event,
    Emitter<PersonalInformationState> emit,
  ) async {
    final response = await catalogRepository.fetchVisaList(CatalogFilter(language: "en"));
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error)),
      (idVisaTypeList) => state.copyWith(idVisaTypeList: idVisaTypeList),
    ));
    return true;
  }

  void _onSetPersonalDetails(
    SetPersonalInfo event,
    Emitter<PersonalInformationState> emit,
  ) {
    final detail = event.uploadUserKycInfo;
    emit(state.copyWith(
      firstName: detail?.firstName,
      middleName: detail?.middleName,
      lastName: detail?.lastName,
      dateOfBirth: detail?.dateOfBirth,
      nationality: detail?.nationality,
      occupation: detail?.occupation,
      idVisaType: detail?.idVisaType,
    ));
  }
}
