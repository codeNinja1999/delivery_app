part of 'operator_profile_bloc.dart';

class OperatorProfileState extends Equatable {
  final DetailedUser? operatorInfo;
  final FormStatus status;

  OperatorProfileState({this.operatorInfo, status}) : status = (status != null) ? status : InitialStatus();

  OperatorProfileState copyWith({
    DetailedUser? operatorInfo,
    FormStatus? status,
  }) {
    return OperatorProfileState(
      operatorInfo: operatorInfo ?? operatorInfo,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [operatorInfo, status];
}
