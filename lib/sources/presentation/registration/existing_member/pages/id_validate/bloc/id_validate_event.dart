part of 'id_validate_bloc.dart';

class IdValidateEvent {}

class CheckExistingMember extends IdValidateEvent {
  final String otpProcessId;
  CheckExistingMember(this.otpProcessId);
}

class GetIdTypeCatalog extends IdValidateEvent {}

class AutoValidateChanged extends IdValidateEvent {
  AutoValidateChanged(this.autoValidate);
  final bool? autoValidate;
}

class IdTypeSelected extends IdValidateEvent {
  final Catalog idType;
  IdTypeSelected(this.idType);
}

class IDNumberChanged extends IdValidateEvent {
  final String idNumber;
  IDNumberChanged(this.idNumber);
}

class DateOfBirthSelected extends IdValidateEvent {
  DateOfBirthSelected(this.dateOfBirth);
  final String dateOfBirth;
}

class TransactionDateSelected extends IdValidateEvent {
  TransactionDateSelected(this.transactionDate);
  final String transactionDate;
}

class TransactionIdChanged extends IdValidateEvent {
  TransactionIdChanged(this.transactionId);
  final String transactionId;
}

class TransactionAmountChanged extends IdValidateEvent {
  TransactionAmountChanged(this.transactionAmount);
  final String transactionAmount;
}
