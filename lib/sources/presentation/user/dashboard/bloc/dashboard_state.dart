part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final FormStatus status;

  DashboardState({
    status,
  }) : status = (status != null) ? status : InitialStatus();

  DashboardState copyWith({
    FormStatus? status,
  }) {
    return DashboardState(
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
