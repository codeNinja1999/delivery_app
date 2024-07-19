part of 'receiving_country_bloc.dart';

class ReceivingCountryState extends Equatable {
  final String? flag;
  final ReceivingCountry? receivingCountry;
  final List<ReceivingCountry>? receivingCountryList;
  final PaymentMode? payoutType;
  final PaymentType paymentType;
  final List<PaymentMode>? payoutTypeList;
  final bool showPaymentMethodDialog;
  final FormStatus status;

  ReceivingCountryState({
    this.flag,
    this.receivingCountry,
    this.receivingCountryList,
    this.payoutType,
    this.paymentType = PaymentType.bank,
    this.payoutTypeList,
    this.showPaymentMethodDialog = false,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  ReceivingCountryState copyWith({
    String? flag,
    ReceivingCountry? receivingCountry,
    List<ReceivingCountry>? receivingCountryList,
    PaymentMode? payoutType,
    PaymentType? paymentType,
    List<PaymentMode>? payoutTypeList,
    bool? showPaymentMethodDialog,
    FormStatus? status,
  }) {
    return ReceivingCountryState(
      flag: flag ?? this.flag,
      receivingCountry: receivingCountry ?? this.receivingCountry,
      receivingCountryList: receivingCountryList ?? this.receivingCountryList,
      payoutTypeList: payoutTypeList ?? this.payoutTypeList,
      payoutType: payoutType ?? this.payoutType,
      paymentType: paymentType ?? this.paymentType,
      showPaymentMethodDialog: showPaymentMethodDialog ?? this.showPaymentMethodDialog,
      status: status ?? InitialStatus(),
    );
  }

  String? get receivingCountryValidation => (receivingCountry != null) ? null : "Please select receiving country";

  @override
  List<Object?> get props => [
        flag,
        receivingCountry,
        receivingCountryList,
        payoutType,
        paymentType,
        payoutTypeList,
        showPaymentMethodDialog,
        status,
      ];
}

enum PaymentType {
  bank("B"),
  card("R"),
  cash("C"),
  wallet("W");

  final String code;

  const PaymentType(this.code);

  factory PaymentType.fromPaymentTypeCode(String code) {
    return values.firstWhere((e) => e.code.toLowerCase() == code.toLowerCase(), orElse: () => PaymentType.cash);
  }
}
