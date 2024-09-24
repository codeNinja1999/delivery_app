import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  EditProfileBloc({required this.userUtilitiesRepository}) : super(EditProfileState()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<MiddleNameChanged>(_onMiddleNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<UserNameChanged>(_onUserNameChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<HouseNumberChanged>(_onHouseNumberChanged);
    on<AdditionalInformationChanged>(_onAdditionalInformationChanged);
    on<SubmitEditProfile>(_onSubmitEditProfile);
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(firstName: event.firstName));
  }

  void _onMiddleNameChanged(MiddleNameChanged event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(middleName: event.middleName));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(lastName: event.lastName));
  }

  void _onUserNameChanged(UserNameChanged event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(userName: event.userName));
  }

  void _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _onHouseNumberChanged(HouseNumberChanged event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(houseNumber: event.houseNumber));
  }

  void _onAdditionalInformationChanged(AdditionalInformationChanged event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(additionalInformation: event.additionalInformation));
  }

  void _onSubmitEditProfile(SubmitEditProfile event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(status: InProgress()));
    final response = userUtilitiesRepository.updateUserProfile(state.data);
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (right) => emit(state.copyWith(status: Success())),
    );
  }
}