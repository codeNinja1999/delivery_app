part of 'id_validate_bloc.dart';

class IdValidateState extends Equatable {
  final String idNumber;
  final String transactionAmount;
  final String transactionId;
  final String transactionDate;
  final String dateOfBirth;
  final Catalog? idType;
  final List<Catalog>? idTypeList;
  final bool autoValidate;
  final CheckExistingMemberResult? checkExistingMemberResult;
  final FormStatus status;

  String? get idNumberValidation => (idNumber != "") ? null : LocaleKeys.idNumberErrorMessage.value;
  String? get dobValidation => (dateOfBirth != "") ? null : LocaleKeys.dobErrorMessage.value;
  String? get idTypeValidation => (idType != null) ? null : LocaleKeys.idTypeErrorMessage.value;
  String? get transactionIdValidation => (transactionId != "") ? null : LocaleKeys.transactionIdErrorMessage.value;
  String? get transactionDateValidation => (transactionDate != "") ? null : LocaleKeys.transactionDateErrorMessage.value;
  String? get transactionAmountValidation =>
      (transactionAmount != "") ? null : LocaleKeys.transactionAmountErrorMessage.value;

  IdValidateState({
    this.idNumber = "",
    this.transactionAmount = "",
    this.transactionId = "",
    this.transactionDate = "",
    this.dateOfBirth = "",
    this.idType,
    this.idTypeList,
    this.autoValidate = false,
    this.checkExistingMemberResult,
    FormStatus? status,
  }) : status = status ?? InitialStatus();

  IdValidateState copyWith({
    bool? isEmail,
    String? idNumber,
    String? transactionAmount,
    String? transactionId,
    String? transactionDate,
    String? dateOfBirth,
    Catalog? idType,
    List<Catalog>? idTypeList,
    bool? autoValidate,
    CheckExistingMemberResult? checkExistingMemberResult,
    FormStatus? status,
  }) {
    return IdValidateState(
      idType: idType ?? this.idType,
      idNumber: idNumber ?? this.idNumber,
      idTypeList: idTypeList ?? this.idTypeList,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      transactionDate:
          transactionDate ?? (autoValidate ?? true ? transactionDate ?? this.transactionDate : this.transactionDate),
      transactionAmount: (autoValidate ?? true ? transactionAmount ?? this.transactionAmount : this.transactionAmount),
      transactionId: (autoValidate ?? true ? transactionId ?? this.transactionId : this.transactionId),
      autoValidate: autoValidate ?? this.autoValidate,
      checkExistingMemberResult: checkExistingMemberResult ?? this.checkExistingMemberResult,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        idType,
        idNumber,
        idTypeList,
        dateOfBirth,
        transactionDate,
        transactionAmount,
        transactionId,
        autoValidate,
        checkExistingMemberResult,
        status,
      ];
}
