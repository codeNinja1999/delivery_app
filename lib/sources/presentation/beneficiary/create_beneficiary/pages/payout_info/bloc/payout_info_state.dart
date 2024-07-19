part of 'payout_info_bloc.dart';

class PayoutInfoState extends Equatable {
  final String fullName;
  final String beneficiaryID;
  final Bank? bank;
  final Branch? branch;
  final String? branchName;
  final String? branchCode;
  final String? accountNumber;
  final bool isEdit;
  final PaymentMode? payoutMode;
  final List<Branch>? branchList;
  final List<Bank>? bankList;
  final Catalog? relation;
  final List<Catalog>? relationList;
  final bool isRelationOther;
  final String? relationOtherDetail;
  final String? phoneNumber;
  final FormStatus status;

  String? get bankValidation => (bank != null) ? null : LocaleKeys.bankErrorMessage.value;
  String? get branchCodeValidation => (branchCode != "") ? null : LocaleKeys.pleaseEnterBranchCode.value;
  String? get ifscCodeValidation => (branchCode != "") ? null : LocaleKeys.pleaseSelectIFSCCode.value;
  String? get payoutLocationValidation => (bank != null) ? null : LocaleKeys.pleaseSelectPayoutLocation.value;
  String? get fullNameValidation => (fullName != "") ? null : LocaleKeys.pleaseEnterBeneficiaryFullName.value;
  String? get relationValidation => (relation != null) ? null : LocaleKeys.relationshipErrorMessage.value;
  String? get phoneNumberValidation =>
      (phoneNumber != null && phoneNumber!.isNotEmpty) ? null : LocaleKeys.pleaseEnterPhoneNumber.value;
  String? get accountNumberValidation =>
      (accountNumber != "" && accountNumber!.isNotEmpty) ? null : LocaleKeys.accountNumberErrorMessage.value;

  PayoutInfoState({
    this.fullName = "",
    this.branchName = "",
    this.branchCode = "",
    this.accountNumber = "",
    this.bank,
    this.branch,
    this.beneficiaryID = "",
    this.isEdit = false,
    this.payoutMode,
    this.branchList,
    this.bankList,
    this.relation,
    this.isRelationOther = false,
    this.relationOtherDetail,
    this.relationList,
    this.phoneNumber,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  PayoutInfoState copyWith({
    String? fullName,
    String? firstName,
    String? middleName,
    String? lastName,
    Bank? bank,
    Branch? branch,
    String? bankBranch,
    String? branchName,
    String? branchCode,
    String? accountNumber,
    String? beneficiaryID,
    bool? isEdit,
    PaymentMode? payoutMode,
    List<Branch>? branchList,
    List<Bank>? bankList,
    bool? isReset,
    Catalog? relation,
    List<Catalog>? idTypeList,
    String? relationOtherDetail,
    bool? isRelationOther,
    List<Catalog>? relationList,
    String? phoneNumber,
    FormStatus? status,
  }) {
    return PayoutInfoState(
      fullName: fullName ?? this.fullName,
      payoutMode: payoutMode ?? this.payoutMode,
      branchName: branchName ?? (isReset ?? false ? "" : this.branchName),
      branchCode: branchCode ?? (isReset ?? false ? "" : this.branchCode),
      accountNumber: accountNumber ?? (isReset ?? false ? "" : this.accountNumber),
      branch: branch ?? (isReset ?? false ? null : this.branch),
      bank: bank ?? (isReset ?? false ? null : this.bank),
      beneficiaryID: beneficiaryID ?? this.beneficiaryID,
      isEdit: isEdit ?? this.isEdit,
      branchList: branchList ?? this.branchList,
      bankList: bankList ?? this.bankList,
      relation: relation ?? this.relation,
      relationOtherDetail: relationOtherDetail ?? this.relationOtherDetail,
      isRelationOther: isRelationOther ?? this.isRelationOther,
      relationList: relationList ?? this.relationList,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        status,
        bank,
        branch,
        branchName,
        branchCode,
        accountNumber,
        payoutMode,
        branchList,
        bankList,
        relation,
        relationList,
        isRelationOther,
        relationOtherDetail,
        phoneNumber,
      ];

  ReceiverPayoutInfo get payoutInfo => _makePayoutData();

  ReceiverPayoutInfo _makePayoutData() {
    return ReceiverPayoutInfo(
      mode: payoutMode,
      currency: Catalog(id: payoutMode?.receiverCurrency ?? "", value: payoutMode?.receiverCurrency ?? ""),
      accountNumber: accountNumber,
      branch: Branch(id: branchCode ?? "", value: branchName ?? ""),
      bank: bank,
    );
  }
}
