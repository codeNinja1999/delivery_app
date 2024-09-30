import 'package:fresh_fold_delivery/repository/domain/pickup_order/pickup_order.dart';
import '../model/create_order/create_order.dart';

extension CreateLaundryRequestDataMapping on PickupOrder {
  CreateOrderRequestModel toCreateOrderRequest() {
    final createOrderRequestModel = CreateOrderRequestModel(
      pickupLocationId: userContactInfo?.locationId,
      pickupDropboxNumber: "1",
      pickupUnitNumber: "1",
      extraPhoneNumber: userContactInfo?.mobileNumber,
      serviceTypes0: serviceType?.id,
      serviceTypes1: "1",
      weightInKg: totalWeight ?? "0",
      userAdditionalInformation: additionalInformation ?? "Something",
      pickupTimeFrom: pickupDate.toString(),
      pickupTimeTo: pickupDate.toString(),
      isSafe: hygieneInfo?.containBiohazard.toString(),
      isSanitary: hygieneInfo?.containBlood.toString(),
      containsPetHair: hygieneInfo?.containPetHair.toString(),
      paymentImage: receiptImage,
    );
    return createOrderRequestModel;
  }
}
