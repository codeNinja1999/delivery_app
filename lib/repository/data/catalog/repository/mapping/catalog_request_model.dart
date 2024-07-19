import 'package:fresh_fold_delivery/repository/data/catalog/model/catalog_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalog_filter.dart';

extension CatalogeRequestDataMapping on CatalogFilter {
  CatalogRequestModel toRequestData({required String catalogType}) {
    final requestData = CatalogRequestModel(
      catalogueType: catalogType,
      language: language,
      field1: countryCode ?? "",
      field2: paymentMode?.id ?? "",
      field3: paymentMode?.receiverCurrency ?? "", //      field3: state?.id ?? "",
      field4: bankId ?? "",
    );
    return requestData;
  }
}
