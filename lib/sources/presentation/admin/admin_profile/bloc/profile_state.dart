part of 'profile_bloc.dart';

class AdminProfileState extends Equatable {
  final DetailedUser? adminInfo;
  final FormStatus status;

  AdminProfileState({this.adminInfo, status}) : status = (status != null) ? status : InitialStatus();

  AdminProfileState copyWith({
    DetailedUser? adminInfo,
    FormStatus? status,
  }) {
    return AdminProfileState(
      adminInfo: adminInfo ?? adminInfo,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [adminInfo, status];
}
