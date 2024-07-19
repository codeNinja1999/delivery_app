import 'package:fresh_fold_delivery/repository/data/transaction/model/confirm_transaction/confirm_transaction_response_model.dart';
import 'package:fresh_fold_delivery/repository/domain/transaction/entities/confirm_transaction/confirm_transaction_result.dart';

extension ConfirmTransactionResponseDataMapping on ConfirmTransactionResponse {
  ConfirmTransactionResult toDomain() {
    final responseData = ConfirmTransactionResult(
      message: message,
      referenceID: refId,
      senderName: senderName,
      collectAmount: collectAmt,
      paymentType: paymentType,
      collectCurrency: collectCurrency,
      payoutAmount: payoutamt,
      promptPayQr: (promptPayQr != null) ? promptPayQr : null,
      sendMode: sendMode,
      apiTokenId: apiTokenId,
      payoutCurrency: payoutcurrency,
      status: status,
      isPinOnHold: isPinOnHold,
    );
    return responseData;
  }
}
