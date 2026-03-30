class AdminPickupOrderResponseModel {
  final int? id;
  final String? userFullName;
  final String? type;
  final String? userAdditionalInformation;
  final int? userId;
  final String? pickupUnitNumber;
  final String? pickupDropboxNumber;
  final String? extraPhoneNumber;
  final int? priceByUser;
  final int? weightInKg;
  final String? status;
  final DateTime? pickupTimeFrom;
  final DateTime? pickupTimeTo;
  final int? isSafe;
  final int? isSanitary;
  final int? containsPetHair;
  final DateTime? createdAt;
  final String? country;
  final String? city;
  final String? neighbourhood;
  final String? postalCode;
  final String? services;

  AdminPickupOrderResponseModel({
    this.id,
    this.userFullName,
    this.type,
    this.userAdditionalInformation,
    this.userId,
    this.pickupUnitNumber,
    this.pickupDropboxNumber,
    this.extraPhoneNumber,
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

  factory AdminPickupOrderResponseModel.fromJson(Map<String, dynamic> json) => AdminPickupOrderResponseModel(
        id: json["id"],
        userFullName: json["user_full_name"],
        type: json["type"],
        userAdditionalInformation: json["user_additional_information"],
        userId: json["user_id"],
        pickupUnitNumber: json["pickup_unit_number"],
        pickupDropboxNumber: json["pickup_dropbox_number"],
        extraPhoneNumber: json["extra_phone_number"],
        priceByUser: json["price_by_user"],
        weightInKg: json["weight_in_kg"],
        status: json["status"],
        pickupTimeFrom: json["pickup_time_from"] == null ? null : DateTime.parse(json["pickup_time_from"]),
        pickupTimeTo: json["pickup_time_to"] == null ? null : DateTime.parse(json["pickup_time_to"]),
        isSafe: json["is_safe"],
        isSanitary: json["is_sanitary"],
        containsPetHair: json["contains_pet_hair"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        country: json["country"],
        city: json["city"],
        neighbourhood: json["neighbourhood"],
        postalCode: json["postal_code"],
        services: json["services"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_full_name": userFullName,
        "type": type,
        "user_additional_information": userAdditionalInformation,
        "user_id": userId,
        "pickup_unit_number": pickupUnitNumber,
        "pickup_dropbox_number": pickupDropboxNumber,
        "extra_phone_number": extraPhoneNumber,
        "price_by_user": priceByUser,
        "weight_in_kg": weightInKg,
        "status": status,
        "pickup_time_from": pickupTimeFrom?.toIso8601String(),
        "pickup_time_to": pickupTimeTo?.toIso8601String(),
        "is_safe": isSafe,
        "is_sanitary": isSanitary,
        "contains_pet_hair": containsPetHair,
        "created_at": createdAt?.toIso8601String(),
        "country": country,
        "city": city,
        "neighbourhood": neighbourhood,
        "postal_code": postalCode,
        "services": services,
      };
}
