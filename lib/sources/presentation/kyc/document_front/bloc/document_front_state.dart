part of 'document_front_bloc.dart';

class DocumentFrontState extends Equatable {
  final FormStatus status;
  final AzureInfo? azureInfo;
  final String? primaryFrontImageName;

  DocumentFrontState({this.azureInfo, this.primaryFrontImageName, status})
      : status = (status != null) ? status : InitialStatus();

  DocumentFrontState copyWith({
    FormStatus? status,
    AzureInfo? azureInfo,
    String? primaryFrontImageName,
  }) {
    return DocumentFrontState(
      status: status ?? InitialStatus(),
      azureInfo: azureInfo ?? this.azureInfo,
      primaryFrontImageName: primaryFrontImageName ?? this.primaryFrontImageName,
    );
  }

  @override
  List<Object?> get props => [azureInfo, status, primaryFrontImageName];
}
