part of 'document_back_bloc.dart';

class DocumentBackState extends Equatable {
  final FormStatus status;
  final String? secondaryImageName;
  final String? countryCode;

  DocumentBackState({this.secondaryImageName, this.countryCode, status})
      : status = (status != null) ? status : InitialStatus();

  DocumentBackState copyWith({
    FormStatus? status,
    String? countryCode,
    String? secondaryImageName,
  }) {
    return DocumentBackState(
      status: status ?? InitialStatus(),
      countryCode: countryCode ?? countryCode,
      secondaryImageName: secondaryImageName ?? this.secondaryImageName,
    );
  }

  @override
  List<Object?> get props => [secondaryImageName, countryCode, status];
}
