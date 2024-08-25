import 'package:fresh_fold_delivery/repository/data/catalog/repository/mapping/catalog_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/catalog/repository/mapping/catalog_response_mapping.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import 'dart:convert';

import '../model/catalog_request_model.dart';
import '../model/catalog_response_model.dart';
import 'mapping/catalog_type_mapping.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl({this.networkClient, this.userNetworkClient});

  NetworkClient? networkClient;
  NetworkClient? userNetworkClient;

  @override
  Future<Either<Exception, List<ServiceType>>> fetchServiceType(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.visaList.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueResponse) {
      return Right(catalogueResponse.catalogueList?.map((item) => item.toServiceType()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<DepositType>>> fetchDepositType(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.receiverType.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueResponse) {
      return Right(catalogueResponse.catalogueList?.map((item) => item.toDepositType()).toList() ?? []);
    });
  }

  @override
  Future<Either<Exception, List<Location>>> fetchLocation(CatalogFilter filter) async {
    final requestData = filter.toRequestData(catalogType: CatalogType.remitCountryList.value);

    final response = await fetchCatalog(requestData);

    return response.fold((error) {
      return Left(error);
    }, (catalogueResponse) {
      return Right(catalogueResponse.catalogueList?.map((item) => item.toLocation()).toList() ?? []);
    });
  }

  Future<Either<Exception, CatalogResponseModel>> fetchCatalog(CatalogRequestModel requestModel) async {
    final requestQuery = requestModel.toJson();

    final endPoint = userNetworkClient;

    final newClient = networkClient ?? userNetworkClient;

    try {
      final response = await newClient?.get(endPoint, queryParameters: requestQuery);
      final responseJson = json.decode(response?.asString ?? "");
      final catalogueResponse = CatalogResponseModel.fromJson(responseJson);

      return Right(catalogueResponse);
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
