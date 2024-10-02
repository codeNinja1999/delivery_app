import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'add_operator_event.dart';
part 'add_operator_state.dart';

class AddOperatorBloc extends Bloc<AddOperatorEvent, AddOperatorState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  AddOperatorBloc({required this.userUtilitiesRepository}) : super(AddOperatorState()) {
    on<SubmitOperator>(_onSubmitOperator);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<MiddleNameChanged>(_onMiddleNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<EmailAddressChanged>(_onEmailAddressChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
  }

  _onSubmitOperator(SubmitOperator event, Emitter<AddOperatorState> emit) async {
    final response = await userUtilitiesRepository.addOperator(state.getData);
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (right) => emit(state.copyWith(status: Success())),
    );
  }

  _onFirstNameChanged(FirstNameChanged event, Emitter<AddOperatorState> emit) async {
    emit(state.copyWith(firstName: event.firstName));
  }

  _onMiddleNameChanged(MiddleNameChanged event, Emitter<AddOperatorState> emit) async {
    emit(state.copyWith(middleName: event.firstName));
  }

  _onLastNameChanged(LastNameChanged event, Emitter<AddOperatorState> emit) async {
    emit(state.copyWith(lastName: event.lastName));
  }

  _onEmailAddressChanged(EmailAddressChanged event, Emitter<AddOperatorState> emit) async {
    emit(state.copyWith(emailAddress: event.emailAddress));
  }

  _onPhoneNumberChanged(PhoneNumberChanged event, Emitter<AddOperatorState> emit) async {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  _onPasswordChanged(PasswordChanged event, Emitter<AddOperatorState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  _onConfirmPasswordChanged(ConfirmPasswordChanged event, Emitter<AddOperatorState> emit) async {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }
}
