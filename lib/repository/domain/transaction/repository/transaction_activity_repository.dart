import 'package:fresh_fold_delivery/repository/repository.dart';

abstract class TransactionActivityRepository {
  Future<Either<Exception, ConfirmTransactionResult>> confirmCreatedTransaction(ConfirmTransactionInfo info);

  Future<Either<Exception, String>> uploadPaymentReceipt(UploadPaymentInfo info);

  Future<Either<Exception, String>> cancelTransaction(CancelTransactionInfo info);
}
