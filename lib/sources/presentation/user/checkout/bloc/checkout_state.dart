part of 'checkout_bloc.dart';

class CheckoutState extends Equatable {
  final String? additionalInformation;
  final File? receiptImage;

  final FormStatus status;

  CheckoutState({this.additionalInformation, this.receiptImage, status})
      : status = (status != null) ? status : InitialStatus();

  CheckoutState copyWith({
    String? additionalInformation,
    File? receiptImage,
    FormStatus? status,
  }) {
    return CheckoutState(
      additionalInformation: additionalInformation ?? this.additionalInformation,
      receiptImage: receiptImage ?? this.receiptImage,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [additionalInformation, receiptImage, status];
}
