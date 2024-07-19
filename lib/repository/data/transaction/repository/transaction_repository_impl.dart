import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/data/app_authentication/data_store/app_credential_data_store.dart';
import 'package:fresh_fold_delivery/repository/data/core/app_service_endpoints.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/model/calculate_transaction/calculate_transaction_response_model.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/model/cancel_transaction/cancel_transaction_request_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/model/confirm_transaction/confirm_transaction_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/model/confirm_transaction/confirm_transaction_response_model.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/model/create_transaction/create_transaction_response_model.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/model/transaction_detail/transaction_detail_response_model.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/model/transaction_history/transaction_history_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/model/transaction_history/transaction_history_response_model.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/repository/mapping/create_transaction_mapping/create_transaction_request_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/repository/mapping/transaction_detail_mapping/transaction_detail_response_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/repository/mapping/upload_payment_mapping/upload_payment_request_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/repository/mapping/confirm_transaction_mapping/confirm_transaction_response_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/repository/mapping/calculate_transaction_mapping/calculate_transaction_request_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/repository/mapping/create_transaction_mapping/create_transaction_response_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/repository/mapping/calculate_transaction_mapping/calculate_transaction_response_data_mapping.dart';
import 'package:network/network.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/repository/mapping/transaction_history_mapping/transaction_history_response_data_mapping.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/transaction/transaction.dart';

class TransactionRepositoryImpl implements TransactionActivityRepository {
  TransactionRepositoryImpl({required this.networkClient});

  final appCredentialStorage = AppCredentialDataStore();
  NetworkClient networkClient;

  final _transactionListStreamController = BehaviorSubject<List<DetailedTransaction>?>.seeded(null);

  @override
  Stream<List<DetailedTransaction>?> transactionList() => _transactionListStreamController.asBroadcastStream();

  @override
  Future<Either<Exception, CalculateTransactionResult>> calculateTransaction(CalculateTransactionInfo info) async {
    final requestData = info.toRequest();
    final postBody = jsonEncode(requestData.toJson());

    try {
      final response = await networkClient.post(AppServiceEndpoints.calculateRemittance, body: postBody, headers: null);
      final credential = CalculateTransactionResponse.fromJson(response.asMap ?? {});
      return Right(credential.toDomain(info));
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, CreateTransactionResult>> createTransaction(CreateTransactionInfo info) async {
    final requestData = info.toRequest();
    final postBody = jsonEncode(requestData.toJson());

    try {
      final response = await networkClient.post(AppServiceEndpoints.registerRemittance, body: postBody);
      final responseData = CreateTransactionResponse.fromJson(response.asMap ?? {});
      final result = responseData.toDomain(info);

      return Right(result);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, ConfirmTransactionResult>> confirmCreatedTransaction(ConfirmTransactionInfo info) async {
    final requestData = ConfirmTransactionRequest(tran: info.transactionID);
    final postBody = jsonEncode(requestData.toJson());

    try {
      final response = await networkClient.post(
        AppServiceEndpoints.commitRemittance,
        body: postBody,
        headers: {"verify-pin": info.tradePassword ?? ""},
      );
      final confirmResponse = ConfirmTransactionResponse.fromJson(response.asMap ?? {});
      return Right(confirmResponse.toDomain());
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, DetailedTransaction>> getTransactionDetail(String id) async {
    try {
      final response = await networkClient.get(AppServiceEndpoints.transactionDetails + id);
      final responseJson = json.decode(response.asString);
      final transactionResponse = TransactionDetailResponseModel.fromJson(responseJson);
      return Right(transactionResponse.toDomain());
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<String> getTransactionList(TransactionListFilter filter) async {
    final query = TransactionHistoryRequest(
      pageNo: filter.pageNumber,
      displayDataNo: filter.itemCount,
      tradeFormDate: filter.startDate,
      tradeToDate: filter.endDate,
      issueType: filter.issueType,
    ).toJson();

    try {
      final response = await networkClient.get(AppServiceEndpoints.transactionList, queryParameters: query);
      final responseJson = json.decode(response.asString);
      final transactionResponse = TransactionHistoryResponse.fromJson(responseJson);

      if (transactionResponse.resultList != null) {
        final transactionList = transactionResponse.resultList!.map((transaction) => transaction.toDomain()).toList();
        _transactionListStreamController.add(transactionList);
      } else {
        _transactionListStreamController.addError(Exception("No transactions"));
        _transactionListStreamController.add(null);
      }
      return "request processed";
    } on Exception catch (error) {
      _transactionListStreamController.addError(error);
      _transactionListStreamController.add(null);
      return "request processed with error";
    }
  }

  @override
  Future<Either<Exception, String>> uploadPaymentReceipt(UploadPaymentInfo info) async {
    final requestData = info.toRequest();
    final requestFormData = jsonEncode(requestData.toJson());
    try {
      final _ = await networkClient.send(
        AppServiceEndpoints.receiptUpload,
        body: requestFormData,
        method: HttpMethod.post,
      );
      // final _ = json.decode(response.asString);
      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> cancelTransaction(CancelTransactionInfo info) async {
    final requestData = CancelTransactionRequest(tranno: info.tranno);
    final postBody = jsonEncode(requestData.toJson());

    try {
      final response = await networkClient.post(AppServiceEndpoints.cancelTransaction, body: postBody);
      final _ = json.decode(response.asString);
      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
