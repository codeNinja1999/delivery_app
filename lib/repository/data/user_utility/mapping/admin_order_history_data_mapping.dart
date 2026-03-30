import '../../../domain/pickup_order/admin_order_result.dart';
import '../model/order_history/admin_order_history_response_model.dart';

extension AdminOrderHistoryDataMapping on AdminPickupOrderResponseModel {
  AdminPickupOrderResult toAdminOrderHistory() {
    final orderHistory = AdminPickupOrderResult(
      id: id,
      fullName: userFullName,
      userId: userId.toString(),
      orderType: type,
      pickupUnitNumber: pickupUnitNumber,
      pickupDropboxNumber: pickupDropboxNumber,
      extraPhoneNumber: extraPhoneNumber,
      userAdditionalInformation: userAdditionalInformation,
      priceByUser: priceByUser,
      weightInKg: weightInKg,
      status: status,
      pickupTimeFrom: pickupTimeFrom,
      pickupTimeTo: pickupTimeTo,
      isSafe: isSafe == 1 ? true : false,
      isSanitary: isSanitary == 1 ? true : false,
      containsPetHair: containsPetHair == 1 ? true : false,
      createdAt: createdAt,
      country: country,
      city: city,
      neighbourhood: neighbourhood,
      postalCode: postalCode,
      services: services,
    );
    return orderHistory;
  }
}
