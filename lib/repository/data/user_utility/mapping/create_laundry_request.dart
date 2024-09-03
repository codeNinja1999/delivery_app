import 'package:fresh_fold_delivery/repository/domain/pickup_order/pickup_order.dart';
import '../model/create_order/create_order.dart';

extension CreateLaundryRequestDataMapping on PickupOrder {
  CreateOrderRequestModel toCreateOrderRequest() {
    final createOrderRequestModel = CreateOrderRequestModel(
      pickupLocationId: userContactInfo?.locationId,
      pickupDropboxNumber: userContactInfo?.locationId,
      extraPhoneNumber: userContactInfo?.locationId,
      serviceTypes0: userContactInfo?.locationId,
      serviceTypes1: userContactInfo?.locationId,
      weightInKg: totalWeight,
      userAdditionalInformation: additionalInformation,
      pickupTimeFrom: userContactInfo?.locationId,
      pickupTimeTo: userContactInfo?.locationId,
      isSafe: hygieneInfo?.containBiohazard.toString(),
      isSanitary: hygieneInfo?.containBlood.toString(),
      containsPetHair: hygieneInfo?.containPetHair.toString(),
      paymentImage: receiptImage,
    );
    return createOrderRequestModel;
  }
}
