// import '../../../domain/user/entities/operator/operator_entities.dart';

// class PickupOrderResponseModel {
//   final int? id;
//   final String? pickupUnitNumber;
//   final String? pickupDropboxNumber;
//   final String? extraPhoneNumber;
//   final String? userAdditionalInformation;
//   final String? operatorAdditionalInformation;
//   final int? priceByUser;
//   final int? finalPrice;
//   final int? weightInKg;
//   final int? actualWeightInKg;
//   final String? status;
//   final DateTime? pickupTimeFrom;
//   final DateTime? pickupTimeTo;
//   final String? actualPickupTime;
//   final String? deliveredTime;
//   final bool? isSafe;
//   final bool? isSanitary;
//   final bool? containsPetHair;
//   final DateTime? createdAt;
//   final DetailedOperator? operator;
//   final PickupLocation? pickupLocation;
//   final List<Service>? services;
//   final List<OrderPayment>? orderPayments;

//   PickupOrderResponseModel({
//     this.id,
//     this.pickupUnitNumber,
//     this.pickupDropboxNumber,
//     this.extraPhoneNumber,
//     this.userAdditionalInformation,
//     this.operatorAdditionalInformation,
//     this.priceByUser,
//     this.finalPrice,
//     this.weightInKg,
//     this.actualWeightInKg,
//     this.status,
//     this.pickupTimeFrom,
//     this.pickupTimeTo,
//     this.actualPickupTime,
//     this.deliveredTime,
//     this.isSafe,
//     this.isSanitary,
//     this.containsPetHair,
//     this.createdAt,
//     this.operator,
//     this.pickupLocation,
//     this.services,
//     this.orderPayments,
//   });

//   factory PickupOrderResponseModel.fromJson(Map<String, dynamic> json) => PickupOrderResponseModel(
//         id: json["id"],
//         pickupUnitNumber: json["pickup_unit_number"],
//         pickupDropboxNumber: json["pickup_dropbox_number"],
//         extraPhoneNumber: json["extra_phone_number"],
//         userAdditionalInformation: json["user_additional_information"],
//         operatorAdditionalInformation: json["operator_additional_information"],
//         priceByUser: json["price_by_user"],
//         finalPrice: json["final_price"],
//         weightInKg: json["weight_in_kg"],
//         actualWeightInKg: json["actual_weight_in_kg"],
//         status: json["status"],
//         pickupTimeFrom: json["pickup_time_from"] == null ? null : DateTime.parse(json["pickup_time_from"]),
//         pickupTimeTo: json["pickup_time_to"] == null ? null : DateTime.parse(json["pickup_time_to"]),
//         actualPickupTime: json["actual_pickup_time"],
//         deliveredTime: json["delivered_time"],
//         isSafe: json["is_safe"],
//         isSanitary: json["is_sanitary"],
//         containsPetHair: json["contains_pet_hair"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         operator: json["operator"],
//         pickupLocation: json["pickup_location"] == null ? null : PickupLocation.fromJson(json["pickup_location"]),
//         services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
//         orderPayments: json["order_payments"] == null
//             ? []
//             : List<OrderPayment>.from(json["order_payments"]!.map((x) => OrderPayment.fromJson(x))),
//       );
// }

// class OrderPayment {
//   final int? id;
//   final String? status;
//   final String? paymentMethod;
//   final String? transactionId;
//   final DateTime? paymentDate;
//   final int? paidPrice;

//   OrderPayment({
//     this.id,
//     this.status,
//     this.paymentMethod,
//     this.transactionId,
//     this.paymentDate,
//     this.paidPrice,
//   });

//   factory OrderPayment.fromJson(Map<String, dynamic> json) => OrderPayment(
//         id: json["id"],
//         status: json["status"],
//         paymentMethod: json["payment_method"],
//         transactionId: json["transaction_id"],
//         paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
//         paidPrice: json["paid_price"],
//       );
// }

// class PickupLocation {
//   final int? id;
//   final String? country;
//   final String? city;
//   final String? neighbourhood;
//   final String? postalCode;

//   PickupLocation({
//     this.id,
//     this.country,
//     this.city,
//     this.neighbourhood,
//     this.postalCode,
//   });

//   factory PickupLocation.fromJson(Map<String, dynamic> json) => PickupLocation(
//         id: json["id"],
//         country: json["country"],
//         city: json["city"],
//         neighbourhood: json["neighbourhood"],
//         postalCode: json["postal_code"],
//       );
// }

// class Service {
//   final int? id;
//   final String? name;
//   final int? price;

//   Service({
//     this.id,
//     this.name,
//     this.price,
//   });

//   factory Service.fromJson(Map<String, dynamic> json) => Service(
//         id: json["id"],
//         name: json["name"],
//         price: json["price"],
//       );
// }
