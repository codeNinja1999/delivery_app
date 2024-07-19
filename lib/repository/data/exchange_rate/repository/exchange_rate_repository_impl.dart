import 'dart:convert';

import 'package:fresh_fold_delivery/repository/repository.dart';

class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  ExchangeRateRepositoryImpl({required this.networkClient});

  NetworkClient networkClient;

  @override
  Future<Either<Exception, RateCalculateResult>> calculateRate(RateCalculateInfo data) async {
    final requestData = data.toRequestData();
    final queryParameters = requestData.toJson();

    try {
      final response = await networkClient.get(AppServiceEndpoints.exchangeRate, queryParameters: queryParameters);
      final responseJson = json.decode(response.asString);
      final exchangeRateResponse = ExchangeRateResponseModel.fromJson(responseJson);
      return Right(exchangeRateResponse.toDomain(data.calculationMode));
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> getExchangeRateList() async {
    final requestData = ExchangeRateRequestModel();
    final queryParameters = requestData.toJson();

    try {
      final _ = await networkClient.get(AppServiceEndpoints.exchangeRateList, queryParameters: queryParameters);
      return const Right("success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, RateHistoryResult>> getExchangeRateHistoryList(
      ExchangeRateHistoryListRequestModel requestModel) async {
    final queryParameters = requestModel.toJson();

    try {
      final response =
          await networkClient.get(AppServiceEndpoints.exchangeRateHistoryList, queryParameters: queryParameters);
      final responseJson = json.decode(response.asString);
      final exchangeRateHistoryListResponse = ExchangeRateHistoryListResponseModel.fromJson(responseJson);
      return Right(exchangeRateHistoryListResponse.toDomain());
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
