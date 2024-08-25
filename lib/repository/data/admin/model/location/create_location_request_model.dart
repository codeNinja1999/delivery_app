class CreateLocationRequestModel {
  final String? country;
  final String? city;
  final String? neighborhood;

  CreateLocationRequestModel({
    this.country,
    this.city,
    this.neighborhood,
  });

  Map<String, dynamic> toJson() => {
        "country": country,
        "city": city,
        "neighbourhood": neighborhood,
      };
}
