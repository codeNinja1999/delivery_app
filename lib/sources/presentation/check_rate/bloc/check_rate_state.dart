part of 'check_rate_bloc.dart';

class CheckRateState extends Equatable {
  final String? flag;
  final String amount;
  final CalculationMode mode;
  final String promotionCode;
  final bool showDiscountPromo;
  final PaymentMode? paymentMode;
  final List<PaymentMode>? paymentModeList;
  final ReceivingCountry? receivingCountry;
  final List<ReceivingCountry>? receivingCountryList;
  final List<DropdownMenuItem<ReceivingCountry>>? dropdownList;
  final CalculateTransactionResult? calculateTransactionResult;
  final FormStatus status;

  String? get receivingCountryValidation => (receivingCountry != null)
      ? null
      : LocaleKeys.receivingCountryErrorMessage.value;
  String? get paymentModeValidation => (paymentMode != null)
      ? null
      : LocaleKeys.receivingMethodErrorMessage.value;

  CheckRateState({
    this.flag,
    this.promotionCode = '',
    this.amount = '',
    this.showDiscountPromo = false,
    this.receivingCountry,
    this.receivingCountryList,
    this.paymentMode,
    this.paymentModeList,
    this.dropdownList,
    this.mode = CalculationMode.viaBase,
    this.calculateTransactionResult,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  CheckRateState copyWith({
    String? amount,
    String? flag,
    String? promotionCode,
    bool? isBeneficiarySelected,
    CalculationMode? mode,
    List<ReceivingCountry>? receivingCountryList,
    ReceivingCountry? receivingCountry,
    PaymentMode? paymentMode,
    List<PaymentMode>? paymentModeList,
    CalculateTransactionResult? calculateTransactionResult,
    CreateTransactionResult? createTransactionResult,
    bool? isReset,
    List<DropdownMenuItem<ReceivingCountry>>? dropdownList,
    FormStatus? status,
  }) {
    return CheckRateState(
      amount: amount ?? this.amount,
      promotionCode: promotionCode ?? this.promotionCode,
      mode: mode ?? this.mode,
      flag: flag ?? this.flag,
      dropdownList: dropdownList ?? this.dropdownList,
      receivingCountryList: receivingCountryList ?? this.receivingCountryList,
      receivingCountry: receivingCountry ?? this.receivingCountry,
      paymentModeList: paymentModeList ?? this.paymentModeList,
      paymentMode:
          paymentMode ?? ((isReset ?? false) ? null : this.paymentMode),
      calculateTransactionResult: calculateTransactionResult ??
          ((isReset ?? false) ? null : this.calculateTransactionResult),
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        amount,
        flag,
        mode,
        dropdownList,
        promotionCode,
        receivingCountryList,
        receivingCountry,
        paymentModeList,
        paymentMode,
        showDiscountPromo,
        calculateTransactionResult,
        status,
      ];
}
