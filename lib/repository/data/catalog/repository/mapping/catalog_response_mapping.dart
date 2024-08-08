import 'package:fresh_fold_delivery/repository/repository.dart';

extension CatalogueResponseDataMapping on CatalogueList {
  Catalog toDomain() {
    final responseData = Catalog(id: data ?? "", value: value ?? "");
    return responseData;
  }

  ServiceType toServiceType() {
    return ServiceType(
      id: data ?? "",
      value: value ?? "",
      price: additionalValue2,
    );
  }

  Location toLocation() {
    return Location(
      id: data ?? "",
      value: value ?? "",
      houseNumber: additionalValue2,
      address: additionalData,
    );
  }

  DepositType toDepositType() {
    return DepositType(id: data ?? "", value: value ?? "");
  }
}
