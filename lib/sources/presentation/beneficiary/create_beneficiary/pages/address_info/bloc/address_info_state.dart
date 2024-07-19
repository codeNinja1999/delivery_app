part of 'address_info_bloc.dart';

class AddressInfoState extends Equatable {
  final String zipCode;
  final String states;
  final String address;
  final bool isEdit;
  final bool fromSendMoney;
  final ReceivingCountry? receivingCountry;
  final List<States>? statesList;
  final DetailedReceiver? detailedReceiver;
  final String? beneficiaryId;
  final FormStatus status;

  String? get addressValidation => (address != "") ? null : LocaleKeys.addressErrorMessage.value;
  String? get zipCodeValidation => (zipCode != "") ? null : LocaleKeys.zipCodeErrorMessage.value;
  String? get stateValidation => (states != "") ? null : LocaleKeys.stateErrorMessage.value;

  AddressInfoState({
    this.zipCode = "",
    this.states = "",
    this.statesList,
    this.address = "",
    this.isEdit = false,
    this.fromSendMoney = false,
    this.detailedReceiver,
    this.receivingCountry,
    this.beneficiaryId,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  AddressInfoState copyWith({
    String? zipCode,
    String? states,
    String? address,
    bool? isEdit,
    bool? fromSendMoney,
    String? beneficiaryId,
    List<PostalAddress>? postalAddressList,
    ReceivingCountry? receivingCountry,
    DetailedReceiver? detailedReceiver,
    List<States>? statesList,
    FormStatus? status,
  }) {
    return AddressInfoState(
      zipCode: zipCode ?? this.zipCode,
      states: states ?? this.states,
      statesList: statesList ?? this.statesList,
      address: address ?? this.address,
      isEdit: isEdit ?? this.isEdit,
      beneficiaryId: beneficiaryId ?? this.beneficiaryId,
      fromSendMoney: fromSendMoney ?? this.fromSendMoney,
      detailedReceiver: detailedReceiver ?? this.detailedReceiver,
      receivingCountry: receivingCountry ?? this.receivingCountry,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        states,
        address,
        beneficiaryId,
        zipCode,
        isEdit,
        fromSendMoney,
        detailedReceiver,
        status,
      ];

  ReceiverContactInfo get addressData => _makeAddressData();

  ReceiverContactInfo _makeAddressData() {
    return ReceiverContactInfo(
      receivingCountry: receivingCountry ?? const ReceivingCountry(id: "", value: ""),
      streetAddress: address,
      postalCode: zipCode,
      state: States(id: states, value: states),
    );
  }
}
