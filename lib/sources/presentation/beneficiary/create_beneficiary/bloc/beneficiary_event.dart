part of 'beneficiary_bloc.dart';

abstract class BeneficiaryEvent {}

class SavePersonalDetail extends BeneficiaryEvent {
  final ReceiverPersonalInfo userPersonalDetail;
  SavePersonalDetail(this.userPersonalDetail);
}

class SaveReceivingCountry extends BeneficiaryEvent {
  final ReceivingCountry? receivingCountry;
  SaveReceivingCountry({required this.receivingCountry});
}

// class SaveFullName extends BeneficiaryEvent {
//   final String? fullName;
//   final Catalog? relation;
//   final String phoneNumber;
//   SaveFullName({
//     required this.fullName,
//     required this.relation,
//     required this.phoneNumber,
//   });
// }

class SavePaymentMode extends BeneficiaryEvent {
  final PaymentMode? paymentMode;
  final PaymentType? paymentType;
  SavePaymentMode({required this.paymentMode, required this.paymentType});
}

class SaveContactDetail extends BeneficiaryEvent {
  final ReceiverContactInfo userContactDetail;
  SaveContactDetail(this.userContactDetail);
}

class SaveIdentityDetails extends BeneficiaryEvent {
  final ReceiverIdentificationInfo receiverIdentityDetails;
  SaveIdentityDetails(this.receiverIdentityDetails);
}

class SaveBankDetail extends BeneficiaryEvent {
  final ReceiverPayoutInfo userBankDetail;
  SaveBankDetail(this.userBankDetail);
}

// class SaveReceiverDetails extends BeneficiaryEvent {
//   final Receiver receiver;
//   SaveReceiverDetails(this.receiver);
// }

class AddInitialData extends BeneficiaryEvent {
  final DetailedReceiver? receiver;
  final CalculateTransactionResult? receiverData;
  AddInitialData({this.receiver, this.receiverData});
}

class GetReceiverDetails extends BeneficiaryEvent {}
