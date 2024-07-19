part of 'exchange_rate_bloc.dart';

class ExchangeRateState extends Equatable {
  final String? flag;
  final String amount;
  final CalculationMode mode;
  final String promotionCode;
  final DetailedUser? userInfo;
  final bool showDiscountPromo;
  final bool? isBeneficiarySelected;
  final bool isPendingTransaction;
  final PaymentMode? paymentMode;
  final List<PaymentMode>? paymentModeList;
  final ReceivingCountry? receivingCountry;
  final List<ReceivingCountry>? receivingCountryList;
  final List<DetailedReceiver>? receiverList;
  final DetailedReceiver? selectedBeneficiary;
  final ExchangeRateViewModel? exchangeRateViewModel;
  final CreateTransactionResult? createTransactionResult;
  final CalculateTransactionResult? calculateTransactionResult;
  final FormStatus status;

  String? get receivingCountryValidation =>
      (receivingCountry != null) ? null : LocaleKeys.receivingCountryErrorMessage.value;
  String? get paymentModeValidation => (paymentMode != null) ? null : LocaleKeys.receivingMethodErrorMessage.value;

  ExchangeRateState({
    this.userInfo,
    this.flag,
    this.promotionCode = '',
    this.amount = '',
    this.isPendingTransaction = false,
    this.showDiscountPromo = false,
    this.isBeneficiarySelected = false,
    this.receivingCountry,
    this.receivingCountryList,
    this.paymentMode,
    this.paymentModeList,
    this.selectedBeneficiary,
    this.receiverList,
    this.mode = CalculationMode.viaBase,
    this.calculateTransactionResult,
    this.createTransactionResult,
    this.exchangeRateViewModel,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  ExchangeRateState copyWith({
    String? amount,
    String? flag,
    String? promotionCode,
    bool? isBeneficiarySelected,
    CalculationMode? mode,
    bool? isPendingTransaction,
    List<DetailedReceiver>? receiverList,
    List<ReceivingCountry>? receivingCountryList,
    ReceivingCountry? receivingCountry,
    PaymentMode? paymentMode,
    List<PaymentMode>? paymentModeList,
    CalculateTransactionResult? calculateTransactionResult,
    CreateTransactionResult? createTransactionResult,
    DetailedReceiver? selectedBeneficiary,
    DetailedUser? userInfo,
    bool? showDiscountPromo,
    ExchangeRateViewModel? exchangeRateViewModel,
    bool? isReset,
    FormStatus? status,
  }) {
    return ExchangeRateState(
      receiverList: receiverList ?? this.receiverList,
      amount: amount ?? this.amount,
      promotionCode: promotionCode ?? this.promotionCode,
      userInfo: userInfo ?? this.userInfo,
      mode: mode ?? this.mode,
      flag: flag ?? this.flag,
      isPendingTransaction: isPendingTransaction ?? this.isPendingTransaction,
      isBeneficiarySelected: isBeneficiarySelected ?? this.isBeneficiarySelected,
      selectedBeneficiary: selectedBeneficiary ?? this.selectedBeneficiary,
      receivingCountryList: receivingCountryList ?? this.receivingCountryList,
      receivingCountry: receivingCountry ?? this.receivingCountry,
      paymentModeList: paymentModeList ?? this.paymentModeList,
      paymentMode: paymentMode ?? ((isReset ?? false) ? null : this.paymentMode),
      calculateTransactionResult:
          calculateTransactionResult ?? ((isReset ?? false) ? null : this.calculateTransactionResult),
      createTransactionResult: createTransactionResult ?? this.createTransactionResult,
      showDiscountPromo: showDiscountPromo ?? this.showDiscountPromo,
      exchangeRateViewModel: exchangeRateViewModel ?? ((isReset ?? false) ? null : this.exchangeRateViewModel),
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        userInfo,
        amount,
        flag,
        mode,
        isBeneficiarySelected,
        isPendingTransaction,
        promotionCode,
        receiverList,
        receivingCountryList,
        receivingCountry,
        paymentModeList,
        paymentMode,
        showDiscountPromo,
        calculateTransactionResult,
        selectedBeneficiary,
        createTransactionResult,
        exchangeRateViewModel,
        status,
      ];
}
