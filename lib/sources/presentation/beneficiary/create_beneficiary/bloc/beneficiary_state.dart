part of 'beneficiary_bloc.dart';

class BeneficiaryState extends Equatable {
  final ReceiverPersonalInfo? personalDetail;
  final ReceiverPayoutInfo? bankDetail;
  final ReceiverContactInfo? contactDetail;
  final String? beneficiaryID;
  final ReceiverIdentificationInfo? receiverIdentificationInfo;
  final DetailedReceiver? detailedReceiver;
  // final Receiver? receiver;
  final bool isEdit;
  final bool fromSendMoney;
  final ReceivingCountry? receivingCountry;
  final CalculateTransactionResult? initialData;
  final PaymentMode? paymentMode;
  final PaymentType? paymentType;
  final String? fullName;
  final Catalog? relation;
  final String? phoneNumber;
  final FormStatus status;

  BeneficiaryState({
    // this.receiver,
    this.fullName,
    this.relation,
    this.personalDetail,
    this.bankDetail,
    this.initialData,
    this.contactDetail,
    this.beneficiaryID,
    this.receiverIdentificationInfo,
    this.detailedReceiver,
    this.isEdit = false,
    this.fromSendMoney = false,
    this.receivingCountry,
    this.paymentMode,
    this.paymentType,
    this.phoneNumber,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  BeneficiaryState copyWith({
    ReceiverPersonalInfo? personalDetail,
    ReceiverContactInfo? contactDetail,
    ReceiverPayoutInfo? bankDetail,
    ReceiverIdentificationInfo? receiverIdentificationInfo,
    DetailedReceiver? detailedReceiver,
    CalculateTransactionResult? initialData,
    Receiver? receiver,
    String? beneficiaryID,
    bool? isEdit,
    bool? fromSendMoney,
    String? fullName,
    Catalog? relation,
    ReceivingCountry? receivingCountry,
    PaymentMode? paymentMode,
    PaymentType? paymentType,
    String? phoneNumber,
    FormStatus? status,
  }) {
    return BeneficiaryState(
      personalDetail: personalDetail ?? this.personalDetail,
      contactDetail: contactDetail ?? this.contactDetail,
      bankDetail: bankDetail ?? this.bankDetail,
      receiverIdentificationInfo: receiverIdentificationInfo ?? this.receiverIdentificationInfo,
      detailedReceiver: detailedReceiver ?? this.detailedReceiver,
      beneficiaryID: beneficiaryID ?? this.beneficiaryID,
      initialData: initialData ?? this.initialData,
      // receiver: receiver ?? this.receiver,
      isEdit: isEdit ?? this.isEdit,
      fromSendMoney: fromSendMoney ?? this.fromSendMoney,
      receivingCountry: receivingCountry ?? this.receivingCountry,
      paymentMode: paymentMode ?? this.paymentMode,
      paymentType: paymentType ?? this.paymentType,
      fullName: fullName ?? this.fullName,
      relation: relation ?? this.relation,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        personalDetail,
        bankDetail,
        contactDetail,
        beneficiaryID,
        initialData,
        fromSendMoney,
        receiverIdentificationInfo,
        detailedReceiver,
        // receiver,
        isEdit,
        receivingCountry,
        paymentMode,
        paymentType,
        fullName,
        relation,
        phoneNumber,
        status,
      ];

  Receiver data(ReceiverContactInfo contactInfo) => _makeData(contactInfo);

  Receiver _makeData(ReceiverContactInfo contactInfo) {
    return Receiver(
      receiverType: const Catalog(id: "", value: ''),
      personalInfo: personalDetail,
      identificationInfo: receiverIdentificationInfo,
      contactInfo: ReceiverContactInfo(
        receivingCountry: receivingCountry ?? const ReceivingCountry(id: "", value: ""),
        streetAddress: contactInfo.streetAddress,
        postalCode: contactInfo.postalCode,
        state: contactInfo.state,
      ),
      defaultPayoutInfo: bankDetail,
    );
  }
}
