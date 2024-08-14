import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<SaveEmail>((event, emit) => emit(state.copyWith(email: event.email)));
    on<SaveOtp>((event, emit) => emit(state.copyWith(otp: event.otp)));
  }
}
