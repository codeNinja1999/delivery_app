class UpdateLocationRequestModel {
  final String? country;
  final String? city;
  final String? neighborhood;

  UpdateLocationRequestModel({
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
