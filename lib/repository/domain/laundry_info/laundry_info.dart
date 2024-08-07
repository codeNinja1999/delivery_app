import 'dart:typed_data';

import '../catalog/entities/catalogs.dart';

class LaundryInfo {
  final Catalog? serviceType;
  final Catalog? paymentType;
  final String? review;
  final Uint8List? receipt;
  final String? totalWeight;
  final String? actualWeight;
  final String? pickupDate;
  final String? deliveryDate;
  final String? pickupAddress;
  final String? totalAmount;

  LaundryInfo({
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
  });
}
