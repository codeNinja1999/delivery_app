part of 'receiver_list_bloc.dart';

abstract class ReceiverListEvent {}

class GetReceiverList extends ReceiverListEvent {}

class BeneficiaryListsSubscriptionRequested extends ReceiverListEvent {}

class UserInfoSubscriptionRequested extends ReceiverListEvent {}

class BeneficiarySelected extends ReceiverListEvent {
  final DetailedReceiver beneficiary;
  BeneficiarySelected({required this.beneficiary});
}

class BeneficiaryDetails extends ReceiverListEvent {
  final String beneficiaryID;
  BeneficiaryDetails({required this.beneficiaryID});
}

class GetPaymentMode extends ReceiverListEvent {
  final PaymentMode? paymentMode;
  final ReceivingCountry? receivingCountry;
  GetPaymentMode(this.paymentMode, this.receivingCountry);
}

class SearchTextChanged extends ReceiverListEvent {
  final String? searchString;
  SearchTextChanged(this.searchString);
}
