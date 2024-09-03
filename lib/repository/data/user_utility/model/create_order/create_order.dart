import 'dart:io';

class CreateOrderRequestModel {
  String? pickupLocationId;
  String? pickupUnitNumber;
  String? pickupDropboxNumber;
  String? extraPhoneNumber;
  String? serviceTypes0;
  String? serviceTypes1;
  String? userAdditionalInformation;
  String? weightInKg;
  String? pickupTimeFrom;
  String? pickupTimeTo;
  String? isSafe;
  String? isSanitary;
  String? containsPetHair;
  File? paymentImage;

  CreateOrderRequestModel({
    this.pickupLocationId,
    this.pickupUnitNumber,
    this.pickupDropboxNumber,
    this.extraPhoneNumber,
    this.serviceTypes0,
    this.serviceTypes1,
    this.userAdditionalInformation,
    this.weightInKg,
    this.pickupTimeFrom,
    this.pickupTimeTo,
    this.isSafe,
    this.isSanitary,
    this.containsPetHair,
    this.paymentImage,
  });

  Map<String, dynamic> toJson() => {
        "pickup_location_id": pickupLocationId,
        "pickup_unit_number": pickupUnitNumber,
        "pickup_dropbox_number": pickupDropboxNumber,
        "extra_phone_number": extraPhoneNumber,
        "service_types[0]": serviceTypes0,
        "service_types[1]": serviceTypes1,
        "user_additional_information": userAdditionalInformation,
        "weight_in_kg": weightInKg,
        "pickup_time_from": pickupTimeFrom,
        "pickup_time_to": pickupTimeTo,
        "is_safe": isSafe,
        "is_sanitary": isSanitary,
        "contains_pet_hair": containsPetHair,
        "payment_image": paymentImage,
      };
}
