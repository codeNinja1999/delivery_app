import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  final UserRegistrationRepository userRegistrationRepository;

  RegisterFormBloc({required this.userRegistrationRepository}) : super(RegisterFormState()) {
    on<FullNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.fullName));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<MobileChanged>((event, emit) {
      emit(state.copyWith(mobileNumber: event.mobileNumber));
    });

    on<PasswordChanged>((event, emit) {
      final isEightCharacterValid = AppRegex.eightDigit.hasMatch(event.password);
      final isUpperCaseValid = AppRegex.oneLetterCapital.hasMatch(event.password);
      final isNumericalValueValid = AppRegex.spacialAndNumeric.hasMatch(event.password);

      emit(
        state.copyWith(
          password: event.password,
          isEightCharacterValid: isEightCharacterValid,
          isUpperCaseValid: isUpperCaseValid,
          isNumericalValueValid: isNumericalValueValid,
        ),
      );
    });
    on<UpdateVerification>((event, emit) {
      emit(state.copyWith(isEmail: event.isEmail));
    });

    on<RegisterUser>(_onRegisterUser);
  }

  void _onRegisterUser(
    RegisterUser event,
    Emitter<RegisterFormState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userRegistrationRepository.register(
      // state.makeRegistrationInfo(event.username, event.processId),
    );
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (right) => state.copyWith(status: Success()),
      ),
    );
  }
}
