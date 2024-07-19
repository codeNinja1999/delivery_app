part of 'document_thickness_bloc.dart';

class DocumentThicknessState extends Equatable {
  final FormStatus status;
  final String? thicknessName;

  DocumentThicknessState({this.thicknessName, status}) : status = (status != null) ? status : InitialStatus();

  DocumentThicknessState copyWith({
    FormStatus? status,
    String? thicknessName,
  }) {
    return DocumentThicknessState(
      status: status ?? InitialStatus(),
      thicknessName: thicknessName ?? this.thicknessName,
    );
  }

  @override
  List<Object?> get props => [thicknessName, status];
}
