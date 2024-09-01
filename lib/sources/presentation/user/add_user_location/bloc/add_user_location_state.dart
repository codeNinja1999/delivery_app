part of 'add_user_location_bloc.dart';

class AddUserLocationState extends Equatable {
  final FormStatus status;

  AddUserLocationState({status}) : status = (status != null) ? status : InitialStatus();

  AddUserLocationState copyWith({
    FormStatus? status,
  }) {
    return AddUserLocationState(
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [status];
}
