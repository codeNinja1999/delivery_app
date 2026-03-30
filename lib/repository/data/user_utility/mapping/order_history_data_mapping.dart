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
