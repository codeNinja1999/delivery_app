part of 'address_info_bloc.dart';

abstract class AddressInfoEvent {}

class ProcessBeneficiary extends AddressInfoEvent {
  final Receiver receiver;
  final String receiverId;
  ProcessBeneficiary({
    required this.receiver,
    required this.receiverId,
  });
}

class FetchReceiverDetail extends AddressInfoEvent {
  final String receiverId;
  FetchReceiverDetail({required this.receiverId});
}

class GetReceiver extends AddressInfoEvent {
  final String? receivingCountry;
  final DetailedReceiver? detailedReceiver;
  final bool isEdit;
  final bool fromSendMoney;
  GetReceiver({this.receivingCountry, this.detailedReceiver, required this.isEdit, required this.fromSendMoney});
}

class ZipCodeChanged extends AddressInfoEvent {
  ZipCodeChanged(this.zipCode);
  final String zipCode;
}

class StateChanged extends AddressInfoEvent {
  StateChanged({
    required this.states,
  });
  final States states;
}

class SetAddressInfo extends AddressInfoEvent {
  final DetailedReceiver? receiver;
  SetAddressInfo({required this.receiver});
}

class AddressChanged extends AddressInfoEvent {
  AddressChanged(this.address);
  final String address;
}
