import 'package:fresh_fold_delivery/repository/data/catalog/model/catalog_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalog_filter.dart';

extension CatalogueRequestDataMapping on CatalogFilter {
  CatalogRequestModel toRequestData({required String catalogType}) {
    final requestData = CatalogRequestModel(
      catalogueType: catalogType,
      language: language,
    );
    return requestData;
  }
}
