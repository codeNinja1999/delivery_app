import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/data/receiver/model/add_receiver/add_receiver_response_model.dart';
import 'package:fresh_fold_delivery/repository/data/receiver/model/get_receiver/get_receiver_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/receiver/model/get_receiver/get_receiver_response_model.dart';
import 'package:fresh_fold_delivery/repository/data/receiver/repository/mapping/add_receiver_response_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/receiver/repository/mapping/receiver_request_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/receiver/repository/mapping/get_receiver_response_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/repository/receiver_repository.dart';
import 'package:network/network.dart';
import 'package:fresh_fold_delivery/repository/data/core/app_service_endpoints.dart';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';

class ReceiverRepositoryImpl implements ReceiverRepository {
  ReceiverRepositoryImpl({required this.networkClient});

  NetworkClient networkClient;
  final _receiverListStreamController = BehaviorSubject<List<DetailedReceiver>?>.seeded(null);

  @override
  Stream<List<DetailedReceiver>?> receiverList() => _receiverListStreamController.asBroadcastStream();

  @override
  Future<Either<Exception, DetailedReceiver>> addReceiver(Receiver appInfo) async {
    final requestData = appInfo.toRequestData();
    final postBody = jsonEncode(requestData.toJson());
    try {
      final response = await networkClient.post(AppServiceEndpoints.createBeneficiary, body: postBody);
      var responseJson = json.decode(response.asString);
      var receiverResponse = AddReceiverResponse.fromJson(responseJson);
      // return Right(receiverResponse.beneficiaryInfo?.beneficiaryId ?? "");

      if (receiverResponse.beneficiaryInfoResponse != null) {
        return Right(receiverResponse.beneficiaryInfoResponse!.toDomain);
      } else {
        return Left(Exception(receiverResponse.addReceiverErrorList?.first.errorMessage ?? "Data Not Found"));
      }
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, DetailedReceiver>> updateReceiver(String id, Receiver appInfo) async {
    final requestData = appInfo.toRequestData();
    final postBody = jsonEncode(requestData.toJson());
    try {
      final response = await networkClient.put(AppServiceEndpoints.updateBeneficiary + id, body: postBody);
      var responseJson = json.decode(response.asString);
      var receiverResponse = AddReceiverResponse.fromJson(responseJson);
      if (receiverResponse.beneficiaryInfoResponse != null) {
        return Right(receiverResponse.beneficiaryInfoResponse!.toDomain);
      } else {
        return Left(Exception(receiverResponse.addReceiverErrorList?.first.errorMessage ?? "Data Not Found"));
      }
      // return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> deleteReceiver(String id) async {
    try {
      final _ = await networkClient.delete(AppServiceEndpoints.deleteBeneficiary + id);
      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, DetailedReceiver>> getReceiverDetail(String id) async {
    try {
      final endPoint = AppServiceEndpoints.beneficiaryInfo + id;

      final response = await networkClient.get(endPoint);
      var responseJson = json.decode(response.asString);
      var receiverResponse = GetReceiverResponse.fromJson(responseJson);
      if (receiverResponse.resultList?.first != null) {
        return Right(receiverResponse.resultList!.first.toDomain);
      } else {
        return Left(Exception(receiverResponse.errorList?.first.errorMessage ?? "Data Not Found"));
      }
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<String> getReceiverList() async {
    final queryData = GetReceiverData(pageNo: "", displayDataNo: "").toJson();
    try {
      final response = await networkClient.get(AppServiceEndpoints.beneficiaryInfo, queryParameters: queryData);
      final receiverResponse = GetReceiverResponse.fromJson(response.asMap ?? {});
      if (receiverResponse.resultList != null) {
        final receiverList = receiverResponse.resultList?.map((beneficiary) => beneficiary.toDomain).toList();
        _receiverListStreamController.add(receiverList);
      } else {
        _receiverListStreamController.addError(Exception("No transactions"));
      }
      return "request processed";
    } on Exception catch (error) {
      _receiverListStreamController.addError(error);
      return "request processed with error";
    }
  }
}
