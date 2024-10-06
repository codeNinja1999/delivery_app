import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../../../../../repository/domain/user/entities/registration/operator_registration_info.dart';

part 'add_operator_event.dart';
part 'add_operator_state.dart';

class SubmissionSuccess extends FormStatus {}

class AddOperatorBloc extends Bloc<AddOperatorEvent, AddOperatorState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  final UserRegistrationRepository userRegistrationRepository;

  late DetailedUser? detailedUser;
  AddOperatorBloc({
    required this.userUtilitiesRepository,
    required this.userRegistrationRepository,
  }) : super(AddOperatorState()) {
    on<GetOperator>(_onGetOperator);
    on<FullNameChanged>(_onFullNameChanged);
    on<EmailAddressChanged>(_onEmailAddressChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SubmitOperator>(_onSubmitOperator);
  }

  _onFullNameChanged(FullNameChanged event, Emitter<AddOperatorState> emit) {
    emit(state.copyWith(fullName: event.fullName));
  }

  _onEmailAddressChanged(EmailAddressChanged event, Emitter<AddOperatorState> emit) {
    emit(state.copyWith(emailAddress: event.emailAddress));
  }

  _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<AddOperatorState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  _onPasswordChanged(PasswordChanged event, Emitter<AddOperatorState> emit) {
    emit(state.copyWith(password: event.password));
  }

  _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<AddOperatorState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  _onGetOperator(GetOperator event, Emitter<AddOperatorState> emit) async {
    emit(state.copyWith(
      fullName: detailedUser?.personalInfo?.fullName,
      userName: detailedUser?.personalInfo?.userName,
      phoneNumber: detailedUser?.personalInfo?.phoneNumber,
      emailAddress: detailedUser?.contactInfo?.emailAddress,
      status: Success(),
    ));
  }

  _onSubmitOperator(SubmitOperator event, Emitter<AddOperatorState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = (detailedUser != null)
        ? await userUtilitiesRepository.updateOperator(state.getData)
        : await userRegistrationRepository.registerOperator(state.getData);
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (right) => emit(state.copyWith(status: SubmissionSuccess())),
    );
  }
}
