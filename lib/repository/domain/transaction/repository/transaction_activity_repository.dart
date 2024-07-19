import 'package:fresh_fold_delivery/repository/repository.dart';

abstract class TransactionActivityRepository {
  Future<Either<Exception, CalculateTransactionResult>> calculateTransaction(CalculateTransactionInfo info);

  Future<Either<Exception, CreateTransactionResult>> createTransaction(CreateTransactionInfo info);

  Future<Either<Exception, ConfirmTransactionResult>> confirmCreatedTransaction(ConfirmTransactionInfo info);

  Stream<List<DetailedTransaction>?> transactionList();

  Future<Either<Exception, String>> uploadPaymentReceipt(UploadPaymentInfo info);

  Future<Either<Exception, String>> cancelTransaction(CancelTransactionInfo info);

  Future<String> getTransactionList(TransactionListFilter filter);

  Future<Either<Exception, DetailedTransaction>> getTransactionDetail(String id);
}
