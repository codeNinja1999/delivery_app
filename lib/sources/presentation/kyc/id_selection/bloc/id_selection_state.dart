part of 'id_selection_bloc.dart';

class IdSelectionState extends Equatable {
  final Catalog? documentType;
  final List<Catalog>? documentTypeList;
  final FormStatus status;

  IdSelectionState({this.documentType, this.documentTypeList, status})
      : status = (status != null) ? status : InitialStatus();

  IdSelectionState copyWith({
    FormStatus? status,
    Catalog? documentType,
    List<Catalog>? documentTypeList,
  }) {
    return IdSelectionState(
      documentType: documentType ?? this.documentType,
      documentTypeList: documentTypeList ?? this.documentTypeList,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [status, documentType, documentTypeList];
}
