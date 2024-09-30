import 'package:fresh_fold_delivery/repository/data/catalog/model/catalog_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalog_filter.dart';

extension AddLocationCatalogueRequestDataMapping on CatalogFilter {
  CatalogRequestModel toAddLocation() {
    return CatalogRequestModel(
      city: city,
      country: country,
      neighborhood: neighborhood,
      postalCode: postalCode,
    );
  }
}

extension AddServiceCatalogueRequestDataMapping on CatalogFilter {
  CatalogRequestModel toAddService() {
    return CatalogRequestModel(
      serviceName: serviceName,
      price: price,
    );
  }
}
