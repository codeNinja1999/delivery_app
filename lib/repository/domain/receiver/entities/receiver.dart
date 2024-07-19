import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_contact_info.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_identification_info.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_payout_info.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_personal_info.dart';

class Receiver {
  final Catalog receiverType;
  final ReceiverPersonalInfo? personalInfo;
  final ReceiverContactInfo? contactInfo;
  final ReceiverIdentificationInfo? identificationInfo;
  final ReceiverPayoutInfo? defaultPayoutInfo;

  Receiver({
    required this.receiverType,
    this.personalInfo,
    this.contactInfo,
    this.identificationInfo,
    this.defaultPayoutInfo,
  });
}

class DetailedReceiver {
  final String? id;
  final Catalog? receiverType;
  final ReceiverPersonalInfo? personalInfo;
  final ReceiverContactInfo? contactInfo;
  final ReceiverIdentificationInfo? identificationInfo;
  final DetailedReceiverPayoutInfo? defaultPayoutInfo;
  final List<DetailedReceiverPayoutInfo>? payoutList;

  @override
  String toString() => personalInfo?.fullName ?? "";

  DetailedReceiver({
    this.id,
    this.receiverType,
    this.personalInfo,
    this.contactInfo,
    this.identificationInfo,
    this.defaultPayoutInfo,
    this.payoutList,
  });
}
