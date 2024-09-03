class UserContactInfo {
  final String id;
  final String? locationId;
  final String? latitude;
  final String? longitude;
  final String? createdTime;
  final String? postalCode;
  final String? unitNumber;
  final String? address;
  final String? city;
  final String? neighborhood;
  final String? houseNumber;
  final String? dropboxNumber;
  final String? emailAddress;
  final String? mobileNumber;

  UserContactInfo({
    required this.id,
    this.locationId,
    this.latitude,
    this.longitude,
    this.address,
    this.city,
    this.neighborhood,
    this.createdTime,
    this.postalCode,
    this.unitNumber,
    this.houseNumber,
    this.dropboxNumber,
    this.emailAddress,
    this.mobileNumber,
  });
}
