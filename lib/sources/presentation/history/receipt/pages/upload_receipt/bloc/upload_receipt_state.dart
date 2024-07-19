part of 'upload_receipt_bloc.dart';

class UploadReceiptState extends Equatable {
  UploadReceiptState({status}) : status = (status != null) ? status : InitialStatus();

  final FormStatus status;

  UploadReceiptState copyWith({FormStatus? status}) {
    return UploadReceiptState(status: status ?? InitialStatus());
  }

  @override
  List<Object?> get props => [status];
}
