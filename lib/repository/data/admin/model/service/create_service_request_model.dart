class CreateServiceRequestModel {
  final String? name;
  final double? price;

  CreateServiceRequestModel({
    this.name,
    this.price,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}
