import '../catalog/entities/catalogs.dart';
import '../user/entities/user_info/user.dart';

class PickupOrderResult {
  final int? id;
  final String? pickupUnitNumber;
  final String? pickupDropboxNumber;
  final String? extraPhoneNumber;
  final String? userAdditionalInformation;
  final String? operatorAdditionalInformation;
  final int? priceByUser;
  final int? finalPrice;
  final int? weightInKg;
  final int? actualWeightInKg;
  final String? status;
  final DateTime? pickupTimeFrom;
  final DateTime? pickupTimeTo;
  final String? actualPickupTime;
  final String? deliveredTime;
  final bool? isSafe;
  final bool? isSanitary;
  final bool? containsPetHair;
  final DateTime? createdAt;
  final DetailedUser? operator;
  final Location? pickupLocation;
  final List<ServiceType>? services;
  final List<OrderPayment>? orderPayments;

  PickupOrderResult({
    this.id,
    this.pickupUnitNumber,
    this.pickupDropboxNumber,
    this.extraPhoneNumber,
    this.userAdditionalInformation,
    this.operatorAdditionalInformation,
    this.priceByUser,
    this.finalPrice,
    this.weightInKg,
    this.actualWeightInKg,
    this.status,
    this.pickupTimeFrom,
    this.pickupTimeTo,
    this.actualPickupTime,
    this.deliveredTime,
    this.isSafe,
    this.isSanitary,
    this.containsPetHair,
    this.createdAt,
    this.operator,
    this.pickupLocation,
    this.services,
    this.orderPayments,
  });
}
