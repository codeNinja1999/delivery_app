part of 'checkout_bloc.dart';

class CheckoutState extends Equatable {
  final String? additionalInformation;
  final File? receiptImage;
  final List<PaymentType> paymentList;
  final PaymentType? selectedPaymentType;
  final FormStatus status;

  CheckoutState({
    this.additionalInformation,
    this.receiptImage,
    this.paymentList = paymentTypeList,
    this.selectedPaymentType,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  CheckoutState copyWith({
    String? additionalInformation,
    File? receiptImage,
    List<PaymentType>? paymentList,
    PaymentType? selectedPaymentType,
    FormStatus? status,
  }) {
    return CheckoutState(
      additionalInformation: additionalInformation ?? this.additionalInformation,
      receiptImage: receiptImage ?? this.receiptImage,
      paymentList: paymentList ?? this.paymentList,
      selectedPaymentType: selectedPaymentType ?? this.selectedPaymentType,
      status: status ?? InitialStatus(),
    );
  }

  static const List<PaymentType> paymentTypeList = [
    PaymentType(id: "1", value: "Credit Card", icon: Icons.credit_card),
    PaymentType(id: "2", value: "FPX", icon: Icons.wallet),
    PaymentType(id: "3", value: "Manual Payment Slip", icon: Icons.image),
  ];

  @override
  List<Object?> get props => [additionalInformation, receiptImage, paymentList, selectedPaymentType, status];
}

class PaymentType {
  final String id;
  final String value;
  final IconData icon;
  const PaymentType({required this.id, required this.value, required this.icon});
}
