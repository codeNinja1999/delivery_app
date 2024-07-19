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

class PaymentMode extends Catalog {
  final String? receiverCurrency;
  final String? paymentType;
  final String? remittanceMethodType;

  const PaymentMode({
    required super.id,
    required super.value,
    this.receiverCurrency,
    this.paymentType,
    this.remittanceMethodType,
  });
}

class Bank extends Catalog {
  final String methodCode;
  const Bank({
    required super.id,
    required super.value,
    required this.methodCode,
  });
}

class Branch extends Catalog {
  const Branch({required super.id, required super.value});
}

class DepositBank extends Catalog {
  final String? imageID;
  final String? accountno;
  final String? accountType;
  final String? accountName;
  final String? nativeAccountName;

  const DepositBank({
    required super.id,
    required super.value,
    this.imageID,
    this.accountno,
    this.accountType,
    this.accountName,
    this.nativeAccountName,
  });
}

class DepositType extends Catalog {
  final String? imageID;
  final String? accountno;

  const DepositType({
    required super.id,
    required super.value,
    this.imageID,
    this.accountno,
  });
}

class States extends Catalog {
  const States({
    required super.id,
    required super.value,
  });
}

class Country extends Catalog {
  final String? accountno;
  final String? accounttype;
  final String? language;
  final String? telephoneCode;
  final String? telephoneLength;
  final String? countryCode;
  final String? currencyCode;
  const Country({
    required super.id,
    required super.value,
    this.accountno,
    this.accounttype,
    this.language,
    this.telephoneCode,
    this.telephoneLength,
    this.countryCode,
    this.currencyCode,
  });
}

class ReceivingCountry extends Catalog {
  final String? accountno;
  final String? accounttype;
  final String? language;
  final String? telephoneCode;
  final String? telephoneLength;
  final String? countryCode;
  final String? currencyCode;
  const ReceivingCountry({
    required super.id,
    required super.value,
    this.accountno,
    this.accounttype,
    this.language,
    this.telephoneCode,
    this.telephoneLength,
    this.countryCode,
    this.currencyCode,
  });
}

class PostalAddress extends Catalog {
  final String? postalAddress;
  final Catalog? state;
  final Catalog? city;
  final String? street;
  final String? street2;
  const PostalAddress({
    required super.id,
    required super.value,
    this.state,
    this.postalAddress,
    this.city,
    this.street,
    this.street2,
  });

  @override
  String toString() => value;
}
