import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';

class ContactInfo {
  final Catalog? country;
  final String? postalCode;
  final Catalog? state;
  final String? stateAlternative;
  final Catalog? city;
  final String? streetAddress;
  final String? japaneseSenderAddress;
  final String? japaneseStreetAddress;
  final String? streetNumber;
  final String? streetName;
  final String? emailAddress;
  final String? mobileNumber;
  final String? telephoneNumber;

  ContactInfo({
    this.country,
    this.postalCode,
    this.state,
    this.stateAlternative,
    this.streetNumber,
    this.city,
    this.streetAddress,
    this.japaneseSenderAddress,
    this.japaneseStreetAddress,
    this.streetName,
    this.emailAddress,
    this.mobileNumber,
    this.telephoneNumber,
  });
}

class UserContactInfo {
  final ContactInfo residentialContactInfo;
  final ContactInfo? wordkContactInfo;

  UserContactInfo({
    required this.residentialContactInfo,
    this.wordkContactInfo,
  });
}
