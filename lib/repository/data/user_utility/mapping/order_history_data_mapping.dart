import '../../../domain/catalog/entities/catalogs.dart';
import '../../../domain/pickup_order/pickup_order_result.dart';
import '../../../domain/user/entities/user_info/user.dart';
import '../model/pickup_order_response_model.dart';

extension OrderHistoryDataMapping on PickupOrderResponseModel {
  PickupOrderResult toOrderHistory() {
    final operator = DetailedUser();
    final serviceList = services
        ?.map((service) => ServiceType(id: service.id.toString(), value: service.name.toString(), price: service.price))
        .toList();

    final location = Location(
      id: pickupLocation?.id.toString() ?? "",
      value: pickupLocation?.country ?? "",
      countryCode: pickupLocation?.country,
      postalCode: pickupLocation?.postalCode,
      neighborhood: pickupLocation?.neighbourhood,
      city: pickupLocation?.city,
    );

    final orderPaymentList = orderPayments
        ?.map((order) => OrderPayment(
              id: order.id,
              status: order.status,
              paidPrice: order.paidPrice,
              paymentDate: order.paymentDate,
              transactionId: order.transactionId,
              paymentMethod: order.paymentMethod,
            ))
        .toList();

    final orderHistory = PickupOrderResult(
      id: id,
      actualPickupTime: actualPickupTime,
      pickupUnitNumber: pickupUnitNumber,
      pickupDropboxNumber: pickupDropboxNumber,
      extraPhoneNumber: extraPhoneNumber,
      userAdditionalInformation: userAdditionalInformation,
      operatorAdditionalInformation: operatorAdditionalInformation,
      priceByUser: priceByUser,
      finalPrice: finalPrice,
      weightInKg: weightInKg,
      actualWeightInKg: actualWeightInKg,
      status: status,
      pickupTimeFrom: pickupTimeFrom,
      pickupTimeTo: pickupTimeTo,
      deliveredTime: deliveredTime,
      isSafe: isSafe,
      isSanitary: isSanitary,
      containsPetHair: containsPetHair,
      createdAt: createdAt,
      operator: operator,
      pickupLocation: location,
      services: serviceList,
      orderPayments: orderPaymentList,
    );
    return orderHistory;
  }
}

// class OrderHistoryMapper {
//   static PickupOrderResult toPickUpOrderHistory(Map<String, dynamic> json) {
//     final history = PickupOrderResult(
//       id: json["id"],
//       pickupUnitNumber: json["pickup_unit_number"],
//       pickupDropboxNumber: json["pickup_dropbox_number"],
//       extraPhoneNumber: json["extra_phone_number"],
//       userAdditionalInformation: json["user_additional_information"],
//       operatorAdditionalInformation: json["operator_additional_information"],
//       priceByUser: json["price_by_user"],
//       finalPrice: json["final_price"],
//       weightInKg: json["weight_in_kg"],
//       actualWeightInKg: json["actual_weight_in_kg"],
//       status: json["status"],
//       pickupTimeFrom: json["pickup_time_from"] == null ? null : DateTime.parse(json["pickup_time_from"]),
//       pickupTimeTo: json["pickup_time_to"] == null ? null : DateTime.parse(json["pickup_time_to"]),
//       actualPickupTime: json["actual_pickup_time"],
//       deliveredTime: json["delivered_time"],
//       isSafe: json["is_safe"],
//       isSanitary: json["is_sanitary"],
//       containsPetHair: json["contains_pet_hair"],
//       createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//       operator: json["operator"],
//       pickupLocation: json["pickup_location"] == null
//           ? null
//           : PickupLocation(
//               id: json["id"],
//               country: json["country"],
//               city: json["city"],
//               neighbourhood: json["neighbourhood"],
//               postalCode: json["postal_code"],
//             ),
//       services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => toService(x))),
//       orderPayments: json["order_payments"] == null
//           ? []
//           : List<OrderPayment>.from(json["order_payments"]!.map((x) => toOrderPayment(x))),
//     );

//     return history;
//   }

//   static OrderPayment toOrderPayment(Map<String, dynamic> json) {
//     return OrderPayment(
//       id: json["id"],
//       status: json["status"],
//       paymentMethod: json["payment_method"],
//       transactionId: json["transaction_id"],
//       paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
//       paidPrice: json["paid_price"],
//     );
//   }

//   static Service toService(Map<String, dynamic> json) {
//     return Service(
//       id: json["id"],
//       name: json["name"],
//       price: json["price"],
//     );
//   }
// }
