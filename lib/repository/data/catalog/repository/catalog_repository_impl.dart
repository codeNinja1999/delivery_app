import 'package:fresh_fold_delivery/repository/data/catalog/repository/mapping/catalog_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/catalog/repository/mapping/catalog_response_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/core/core.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import 'dart:convert';

import '../model/catalog_request_model.dart';
import '../model/catalog_response_model.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl({required this.networkClient, required this.userNetworkClient});

  NetworkClient networkClient;
  NetworkClient userNetworkClient;

  @override
  Future<Either<Exception, List<Location>>> fetchLocation() async {
    try {
      final response = await userNetworkClient.get(AppServiceEndpoints.fetchLocation);
      final responseJson = json.decode(response.asString);
      final catalogueResponse = CatalogResponseModel.fromJson(responseJson);

      return Right(catalogueResponse.catalogueList?.map((item) => item.toLocation()).toList() ?? []);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> addLocation(CatalogFilter filter) async {
    final requestData = filter.toAddLocation();
    final requestQuery = requestData.toJson();

    try {
      final response = await userNetworkClient.post(AppServiceEndpoints.createLocation, queryParameters: requestQuery);
      final responseJson = json.decode(response.asString );
      final _ = CatalogResponseModel.fromJson(responseJson);

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> deleteLocation(String locationId) async {
    try {
      final response = await userNetworkClient.get(AppServiceEndpoints.deleteLocation + locationId);
      final responseJson = json.decode(response.asString );
      final _ = CatalogResponseModel.fromJson(responseJson);

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> updateLocation(CatalogFilter filter) async {
    final requestData = filter.toAddLocation();
    final requestQuery = requestData.toJson();
    try {
      final response =
          await userNetworkClient.patch(AppServiceEndpoints.updateLocation + filter.id.toString(), body: requestQuery);
      final responseJson = json.decode(response.asString );
      final _ = CatalogResponseModel.fromJson(responseJson);

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> addServiceType(CatalogFilter filter) async {
    final requestData = filter.toAddService();
    final requestQuery = requestData.toJson();

    try {
      final response = await userNetworkClient.post(AppServiceEndpoints.fetchLocation, queryParameters: requestQuery);
      final responseJson = json.decode(response.asString );
      final _ = CatalogResponseModel.fromJson(responseJson);

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, List<ServiceType>>> fetchServiceType() async {
    try {
      final response = await userNetworkClient.get(AppServiceEndpoints.fetchServiceType);
      final responseJson = json.decode(response.asString );
      final catalogueResponse = CatalogResponseModel.fromJson(responseJson);

      return Right(catalogueResponse.catalogueList?.map((item) => item.toServiceType()).toList() ?? []);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> deleteServiceType(String serviceId) async {
    try {
      final response = await userNetworkClient.get(AppServiceEndpoints.deleteService + serviceId);
      final responseJson = json.decode(response.asString );
      final _ = CatalogResponseModel.fromJson(responseJson);

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> updateServiceType(CatalogFilter filter) async {
    final requestData = filter.toAddLocation();
    final requestQuery = requestData.toJson();
    try {
      final response =
          await userNetworkClient.patch(AppServiceEndpoints.updateService + filter.id.toString(), body: requestQuery);
      final responseJson = json.decode(response.asString );
      final _ = CatalogResponseModel.fromJson(responseJson);

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  Future<Either<Exception, CatalogResponseModel>> fetchCatalog(CatalogRequestModel requestModel) async {
    final requestQuery = requestModel.toJson();

    final endPoint = userNetworkClient;


    try {
      final response = await userNetworkClient.get(endPoint, queryParameters: requestQuery);
      final responseJson = json.decode(response.asString );
      final catalogueResponse = CatalogResponseModel.fromJson(responseJson);

      return Right(catalogueResponse);
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
