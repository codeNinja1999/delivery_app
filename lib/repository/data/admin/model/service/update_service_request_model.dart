class UpdateServiceRequestModel {
  final String? name;
  final double? price;

  UpdateServiceRequestModel({
    this.name,
    this.price,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}
