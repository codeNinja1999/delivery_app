import 'dart:io';
import 'dart:typed_data';

import 'package:fresh_fold_delivery/repository/domain/domain.dart';
import '../hygiene_info/hygiene_info.dart';

class PickupOrder {
  final Catalog? serviceType;
  final Catalog? paymentType;
  final String? review;
  final Uint8List? receipt;
  final String? totalWeight;
  final String? actualWeight;
  final DateTime? pickupDate;
  final String? deliveryDate;
  final String? pickupAddress;
  final String? totalAmount;
  final HygieneInfo? hygieneInfo;
  final String? additionalInformation;
  final UserContactInfo? userContactInfo;
  final File? receiptImage;

  PickupOrder({
    this.serviceType,
    this.totalWeight,
    this.totalAmount,
    this.actualWeight,
    this.pickupDate,
    this.deliveryDate,
    this.pickupAddress,
    this.paymentType,
    this.review,
    this.receipt,
    this.hygieneInfo,
    this.additionalInformation,
    this.userContactInfo,
    this.receiptImage,
  });
}
