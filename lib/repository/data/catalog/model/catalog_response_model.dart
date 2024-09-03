class CatalogResponseModel {
  List<Datum>? data;

  CatalogResponseModel({
    this.data,
  });

  factory CatalogResponseModel.fromJson(Map<String, dynamic> json) => CatalogResponseModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  int? id;
  String? country;
  String? city;
  String? neighborhood;
  String? postalCode;
  String? name;
  int? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Datum({
    this.id,
    this.country,
    this.city,
    this.neighborhood,
    this.postalCode,
    this.name,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        country: json["country"],
        city: json["city"],
        neighborhood: json["neighbourhood"],
        postalCode: json["postal_code"],
        name: json["name"],
        price: json["price"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null ? null : DateTime.parse(json["deleted_at"]),
      );
}
