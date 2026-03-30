class AdminPickupOrderResult {
  final int? id;
  final String? fullName;
  final String? orderType;
  final String? userId;
  final String? pickupUnitNumber;
  final String? pickupDropboxNumber;
  final String? extraPhoneNumber;
  final String? userAdditionalInformation;
  final int? priceByUser;
  final int? weightInKg;
  final String? status;
  final DateTime? pickupTimeFrom;
  final DateTime? pickupTimeTo;
  final bool? isSafe;
  final bool? isSanitary;
  final bool? containsPetHair;
  final DateTime? createdAt;
  final String? country;
  final String? city;
  final String? neighbourhood;
  final String? postalCode;
  final String? services;

  AdminPickupOrderResult({
    this.id,
    this.fullName,
    this.orderType,
    this.userId,
    this.pickupUnitNumber,
    this.pickupDropboxNumber,
    this.extraPhoneNumber,
    this.userAdditionalInformation,
    this.priceByUser,
    this.weightInKg,
    this.status,
    this.pickupTimeFrom,
    this.pickupTimeTo,
    this.isSafe,
    this.isSanitary,
    this.containsPetHair,
    this.createdAt,
    this.country,
    this.city,
    this.neighbourhood,
    this.postalCode,
    this.services,
  });
}
