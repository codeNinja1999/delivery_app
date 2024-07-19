import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';

class ReceiverContactInfo {
  final ReceivingCountry receivingCountry;
  final String? postalCode;
  final States? state;
  final String? stateAlternative;
  final Catalog? city;
  final String? streetAddress;
  final String? address2;
  final String? emailAddress;
  final String? mobileNumber;
  final String? telephoneNumber;
  final String? receiverNativeAddress;

  ReceiverContactInfo({
    required this.receivingCountry,
    this.postalCode,
    this.state,
    this.stateAlternative,
    this.city,
    this.streetAddress,
    this.address2,
    this.emailAddress,
    this.mobileNumber,
    this.telephoneNumber,
    this.receiverNativeAddress,
  });
}
