class CatalogRequestModel {
  final String? language;
  final String? country;
  final String? city;
  final String? neighborhood;
  final String? price;
  final String? serviceName;
  final int? postalCode;

  CatalogRequestModel({
    this.country,
    this.city,
    this.price,
    this.language,
    this.serviceName,
    this.neighborhood,
    this.postalCode,
  });

  Map<String, dynamic> toJson() => {
        "country": country,
        "city": city,
        "language": language,
        "neighbourhood": neighborhood,
        "postal_code": postalCode,
        "name": serviceName,
        "price": price
      };
}
