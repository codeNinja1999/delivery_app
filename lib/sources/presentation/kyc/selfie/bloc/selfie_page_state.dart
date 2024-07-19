part of 'selfie_page_bloc.dart';

class SelfiePageState extends Equatable {
  final FormStatus status;
  final String? selfieImageName;

  SelfiePageState({
    this.selfieImageName,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  SelfiePageState copyWith({
    FormStatus? status,
    String? selfieImageName,
  }) {
    return SelfiePageState(
      selfieImageName: selfieImageName,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [status, selfieImageName];
}
