import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserAuthenticationRepository userAuthenticationRepository;
  LoginBloc({required this.userAuthenticationRepository}) : super(LoginState()) {
    on<AuthenticateUser>(_onUserLogin);

    on<UsernameNumberChanged>((event, emit) {
      emit(state.copyWith(username: event.username));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<RememberMe>((event, emit) {
      emit(state.copyWith(isRememberMe: !state.isRememberMe));
    });

    on<CheckUserIfPersist>(_onCheckUser);

    add(CheckUserIfPersist());
  }

  void _onCheckUser(
    CheckUserIfPersist event,
    Emitter<LoginState> emit,
  ) async {
    final response = await userAuthenticationRepository.getUser();
    response.fold(
        (error) => null,
        (username) => username != null
            ? emit(
                state.copyWith(
                  persistUsername: username,
                  username: username,
                  isRememberMe: true,
                ),
              )
            : null);
  }

  void _onUserLogin(
    LoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    // final loginInfo = LoginInfo(
    //   email: "",
    //   password: "",
    // );
    // final response = await userAuthenticationRepository.authenticateUser(loginInfo);

    // response.fold((error) {
    //   if (error is NewDeviceDetected) {
    //     emit(state.copyWith(
    //         shouldVerifyDevice: true,
    //         loginViewModel: LoginViewModel(
    //           username: state.username,
    //           password: state.password,
    //           deviceVerificationProcessId: error.toString(),
    //           shouldRemember: state.shouldVerifyDevice,
    //         )));
    //   } else {
    //     emit(state.copyWith(status: SubmissionFailure(error)));
    //   }
    // }, (right) async {
    //   updateUserPersistance();
    //   emit(state.copyWith(status: Success()));
    // });
  }

  Future<Either<Exception, String>> updateUserPersistance() async {
    if (state.isRememberMe) {
      final response = await userAuthenticationRepository.getUser();
      if (response.right != state.username) {
        return await userAuthenticationRepository.persistUser(state.username);
      } else {
        return const Right("success");
      }
    } else {
      return await userAuthenticationRepository.clearPersistUser();
    }
  }
}
