import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/data/account_utility/repository/mappings/transaction_pin_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/core/app_service_endpoints.dart';
import 'package:fresh_fold_delivery/repository/domain/account_utility/entities/change_transaction_pin.dart';
import 'package:fresh_fold_delivery/repository/domain/account_utility/repository/transaction_pin_repository.dart';
import 'package:network/network.dart';

class TransactionPinRepositoryImpl implements TransactionPinRepository {
  TransactionPinRepositoryImpl({required this.networkClient});

  NetworkClient networkClient;
  @override
  Future<Either<Exception, String>> changeTransactionPin(ChangeTradePinInfo data) async {
    final requestData = data.toRequestData();
    final parameter = requestData.toJson();

    try {
      final _ = await networkClient.put(AppServiceEndpoints.changeTransactionpin, queryParameters: parameter);
      return const Right("Sucess");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> resetTransactionPin(ChangeTradePinInfo data) async {
    final requestData = data.toRequestData();
    final parameter = requestData.toJson();
    try {
      final _ = await networkClient.put(AppServiceEndpoints.changeTransactionpin, queryParameters: parameter);

      return const Right("Sucess");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> setTransactionPin(ChangeTradePinInfo data) async {
    final requestData = data.toRequestData();
    final parameter = requestData.toJson();
    try {
      final _ = await networkClient.put(AppServiceEndpoints.changeTransactionpin, queryParameters: parameter);
      return const Right("Sucess");
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
