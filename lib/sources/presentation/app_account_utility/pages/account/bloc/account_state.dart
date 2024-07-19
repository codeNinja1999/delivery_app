part of 'account_bloc.dart';

class AccountState extends Equatable {
  final DetailedUser? userInfo;
  final FormStatus status;

  AccountState({this.userInfo, status}) : status = (status != null) ? status : InitialStatus();

  AccountState copyWith({
    DetailedUser? userInfo,
    FormStatus? status,
  }) {
    return AccountState(
      userInfo: userInfo ?? userInfo,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [userInfo, status];
}
