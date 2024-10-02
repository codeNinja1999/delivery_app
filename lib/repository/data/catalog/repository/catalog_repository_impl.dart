import 'dart:convert';

import 'package:fresh_fold_delivery/repository/data/core/core.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

import '../model/catalog_request_model.dart';
import '../model/catalog_response_model.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl({required this.networkClient, required this.userNetworkClient});

  NetworkClient networkClient;
  NetworkClient userNetworkClient;

  @override
  Future<Either<Exception, List<Location>>> fetchLocation() async {
    try {
      final response = await userNetworkClient.get(AppServiceEndpoints.location);
      final responseJson = json.decode(response.asString);
      final locations = (responseJson as List<dynamic>)
          .map((item) => Location(
                id: item['id'].toString(),
                value: item['country'] ?? item['value'],
                city: item['city'],
                neighborhood: item['neighbourhood'],
                postalCode: item['postal_code'],
              ))
          .toList();
      return Right(locations);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> addLocation(CatalogFilter filter) async {
    // final requestData = filter.toAddLocation();
    // final requestBody = requestData.toJson();

    final requestBody = json.encode({
      "country": filter.country,
      "city": filter.city,
      "neighbourhood": filter.neighborhood,
    });

    try {
      final response = await userNetworkClient.post(AppServiceEndpoints.createLocation, body: requestBody);
      final responseJson = json.decode(response.asString);
      final _ = CatalogResponseModel.fromJson(responseJson);

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> deleteLocation(CatalogFilter filter) async {
    final requestBody = json.encode({
      "country": filter.country,
      "city": filter.city,
      "neighbourhood": filter.neighborhood,
    });
    final endPoint = "${AppServiceEndpoints.deleteLocation}${filter.id}";
    try {
      final response = await userNetworkClient.delete(endPoint, body: requestBody);
      final responseJson = json.decode(response.asString);
      final _ = CatalogResponseModel.fromJson(responseJson);

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> updateLocation(CatalogFilter filter) async {
    // final requestData = filter.toAddLocation();
    final requestBody = json.encode({
      "country": filter.country,
      "city": filter.city,
      "neighbourhood": filter.neighborhood,
    });
    final endPoint = "${AppServiceEndpoints.updateLocation}${filter.id}";
    try {
      final response = await userNetworkClient.patch(endPoint, body: requestBody);
      final responseJson = json.decode(response.asString);
      final _ = CatalogResponseModel.fromJson(responseJson);

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> addServiceType(CatalogFilter filter) async {
    // final requestData = filter.toAddService();
    // final requestBody = requestData.toJson();
    final requestBody = json.encode({
      "name": filter.serviceName,
      "price": filter.price,
    });

    try {
      final response = await userNetworkClient.post(AppServiceEndpoints.createService, body: requestBody);
      final responseJson = json.decode(response.asString);
      final _ = CatalogResponseModel.fromJson(responseJson);

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, List<ServiceType>>> fetchServiceType() async {
    try {
      final response = await userNetworkClient.get(AppServiceEndpoints.fetchService);
      final responseJson = json.decode(response.asString);
      final serviceType = (responseJson as List<dynamic>)
          .map((item) => ServiceType(
                id: item['id'].toString(),
                value: item['name'] ?? "",
                price: item['price'],
              ))
          .toList();
      return Right(serviceType);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> deleteServiceType(CatalogFilter filter) async {
    final requestBody = json.encode({
      "name": filter.serviceName,
      "price": filter.price,
    });
    final endPoint = "${AppServiceEndpoints.deleteService}${filter.id}";
    try {
      final response = await userNetworkClient.delete(endPoint, body: requestBody);
      final responseJson = json.decode(response.asString);
      final _ = CatalogResponseModel.fromJson(responseJson);

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> updateServiceType(CatalogFilter filter) async {
    // final requestData = filter.toAddLocation();
    // final requestQuery = requestData.toJson();
    final requestBody = json.encode({
      "name": filter.serviceName,
      "price": filter.price,
    });
    final endPoint = "${AppServiceEndpoints.updateService}${filter.id}";

    try {
      final response = await userNetworkClient.patch(endPoint, body: requestBody);
      final responseJson = json.decode(response.asString);
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
      final responseJson = json.decode(response.asString);
      final catalogueResponse = CatalogResponseModel.fromJson(responseJson);

      return Right(catalogueResponse);
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
