import 'package:equatable/equatable.dart';

class Catalog extends Equatable {
  final String id;
  final String value;

  const Catalog({required this.id, required this.value});

  @override
  List<Object> get props => [id, value];

  @override
  String toString() => value;
}

class DepositType extends Catalog {
  const DepositType({required super.id, required super.value});
}

class ServiceType extends Catalog {
  final int? price;
  const ServiceType({required super.id, required super.value, this.price});
}

class Location extends Catalog {
  final String? houseNumber;
  final String? city;
  final String? neighborhood;
  final String? postalCode;
  final String? countryCode;
  const Location({
    required super.id,
    required super.value,
    this.houseNumber,
    this.city,
    this.postalCode,
    this.countryCode,
    this.neighborhood,
  });
}

class OrderPayment {
  final int? id;
  final String? status;
  final String? paymentMethod;
  final String? transactionId;
  final DateTime? paymentDate;
  final int? paidPrice;

  OrderPayment({
    this.id,
    this.status,
    this.paymentMethod,
    this.transactionId,
    this.paymentDate,
    this.paidPrice,
  });
}
