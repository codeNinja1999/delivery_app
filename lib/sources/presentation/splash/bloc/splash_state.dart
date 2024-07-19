part of 'splash_bloc.dart';

class UpdateAvailable extends FormStatus {
  final bool needForceUpdate;
  final String message;

  UpdateAvailable({required this.needForceUpdate, required this.message});
}

class AppUnderMaintenance extends FormStatus {
  final String message;

  AppUnderMaintenance(this.message);
}

class SplashState extends Equatable {
  final FormStatus status;

  SplashState({status}) : status = (status != null) ? status : InitialStatus();

  SplashState copyWith({FormStatus? status}) {
    return SplashState(status: status ?? InitialStatus());
  }

  @override
  List<Object?> get props => [status];
}
