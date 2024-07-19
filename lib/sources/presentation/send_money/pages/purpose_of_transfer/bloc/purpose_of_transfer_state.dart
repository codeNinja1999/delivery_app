part of 'purpose_of_transfer_bloc.dart';

class PurposeOfTransferState extends Equatable {
  final Catalog? purposeOfRemittance;
  final String purposeOfRemittanceOther;
  final Catalog? sourceOfFund;
  final String sourceOfFundOther;
  final List<Catalog>? purposeOfRemittanceList;
  final List<DepositType>? depositMethodTypeList;
  final DepositType? depositMethodType;
  final List<Catalog>? sourceOfFundList;
  final CreateTransactionResult? createTransactionResult;
  final FormStatus status;

  String? get purposeOfRemitValidation => (purposeOfRemittance != null) ? null : LocaleKeys.purposeRemit.value;
  String? get sourceOfFundValidation => (sourceOfFund != null) ? null : LocaleKeys.sourceOfFundErrorMessage.value;
  String? get purposeOfRemittanceOtherValidation => (purposeOfRemittance?.id == "99")
      ? (purposeOfRemittanceOther != "")
          ? null
          : LocaleKeys.purposeOfTransferOtherErrorMessage.value
      : null;
  String? get sourceOfFundOtherValidation => (sourceOfFund?.id == "99")
      ? (sourceOfFundOther != "")
          ? null
          : LocaleKeys.sourceOfFundOtherErrorMessage.value
      : null;

  PurposeOfTransferState({
    this.purposeOfRemittanceList,
    this.sourceOfFundList,
    this.purposeOfRemittance,
    this.sourceOfFund,
    this.sourceOfFundOther = "",
    this.depositMethodType,
    this.depositMethodTypeList,
    this.purposeOfRemittanceOther = "",
    this.createTransactionResult,
    status,
  }) : status = (status != null) ? status : InitialStatus();
  PurposeOfTransferState copyWith({
    Catalog? purposeOfRemittance,
    Catalog? sourceOfFund,
    String? sourceOfFundOther,
    String? purposeOfRemittanceOther,
    DepositType? depositMethodType,
    List<DepositType>? depositMethodTypeList,
    List<Catalog>? purposeOfRemittanceList,
    List<Catalog>? sourceOfFundList,
    CreateTransactionResult? createTransactionResult,
    FormStatus? status,
  }) {
    final state = PurposeOfTransferState(
      purposeOfRemittance: purposeOfRemittance ?? this.purposeOfRemittance,
      sourceOfFund: sourceOfFund ?? this.sourceOfFund,
      sourceOfFundOther: sourceOfFundOther ?? this.sourceOfFundOther,
      depositMethodType: depositMethodType ?? this.depositMethodType,
      depositMethodTypeList: depositMethodTypeList ?? this.depositMethodTypeList,
      purposeOfRemittanceOther: purposeOfRemittanceOther ?? this.purposeOfRemittanceOther,
      purposeOfRemittanceList: purposeOfRemittanceList ?? this.purposeOfRemittanceList,
      sourceOfFundList: sourceOfFundList ?? this.sourceOfFundList,
      createTransactionResult: createTransactionResult ?? this.createTransactionResult,
      status: status ?? InitialStatus(),
    );
    return state;
  }

  @override
  List<Object?> get props => [
        purposeOfRemittance,
        sourceOfFund,
        sourceOfFundOther,
        depositMethodType,
        depositMethodTypeList,
        purposeOfRemittanceOther,
        purposeOfRemittanceList,
        sourceOfFundList,
        createTransactionResult,
        status,
      ];
}
