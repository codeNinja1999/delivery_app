part of 'selfie_bloc.dart';

class SelfieState extends Equatable {
  final AzureInfo? azureInfo;
  final String? selfieImageName;
  final FormStatus status;

  SelfieState({
    this.azureInfo,
    this.selfieImageName,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  SelfieState copyWith({
    AzureInfo? azureInfo,
    String? profileImageName,
    FormStatus? status,
  }) {
    return SelfieState(
      azureInfo: azureInfo ?? azureInfo,
      selfieImageName: selfieImageName ?? selfieImageName,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [azureInfo, selfieImageName, status];
}
