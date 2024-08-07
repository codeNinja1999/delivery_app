import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/data/core/app_service_endpoints.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/model/cancel_transaction/cancel_transaction_request_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/model/confirm_transaction/confirm_transaction_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/model/confirm_transaction/confirm_transaction_response_model.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/repository/mapping/upload_payment_mapping/upload_payment_request_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/repository/mapping/confirm_transaction_mapping/confirm_transaction_response_data_mapping.dart';
import 'package:network/network.dart';

import '../../../domain/transaction/transaction.dart';

class TransactionRepositoryImpl implements TransactionActivityRepository {
  TransactionRepositoryImpl({required this.networkClient});

  NetworkClient networkClient;

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
