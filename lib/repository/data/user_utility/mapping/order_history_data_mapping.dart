import '../../../domain/pickup_order/pickup_order_result.dart';

class OrderHistoryMapper {
  static PickupOrderResult toPickUpOrderHistory(Map<String, dynamic> json) {
    final history = PickupOrderResult(
      id: json["id"],
      pickupUnitNumber: json["pickup_unit_number"],
      pickupDropboxNumber: json["pickup_dropbox_number"],
      extraPhoneNumber: json["extra_phone_number"],
      userAdditionalInformation: json["user_additional_information"],
      operatorAdditionalInformation: json["operator_additional_information"],
      priceByUser: json["price_by_user"],
      finalPrice: json["final_price"],
      weightInKg: json["weight_in_kg"],
      actualWeightInKg: json["actual_weight_in_kg"],
      status: json["status"],
      pickupTimeFrom: json["pickup_time_from"] == null ? null : DateTime.parse(json["pickup_time_from"]),
      pickupTimeTo: json["pickup_time_to"] == null ? null : DateTime.parse(json["pickup_time_to"]),
      actualPickupTime: json["actual_pickup_time"],
      deliveredTime: json["delivered_time"],
      isSafe: json["is_safe"],
      isSanitary: json["is_sanitary"],
      containsPetHair: json["contains_pet_hair"],
      createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      operator: json["operator"],
      pickupLocation: json["pickup_location"] == null
          ? null
          : PickupLocation(
              id: json["id"],
              country: json["country"],
              city: json["city"],
              neighbourhood: json["neighbourhood"],
              postalCode: json["postal_code"],
            ),
      services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => toService(x))),
      orderPayments: json["order_payments"] == null
          ? []
          : List<OrderPayment>.from(json["order_payments"]!.map((x) => toOrderPayment(x))),
    );

    return history;
  }

  static OrderPayment toOrderPayment(Map<String, dynamic> json) {
    return OrderPayment(
      id: json["id"],
      status: json["status"],
      paymentMethod: json["payment_method"],
      transactionId: json["transaction_id"],
      paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
      paidPrice: json["paid_price"],
    );
  }

  static Service toService(Map<String, dynamic> json) {
    return Service(
      id: json["id"],
      name: json["name"],
      price: json["price"],
    );
  }
}
