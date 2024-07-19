import 'package:fresh_fold_delivery/repository/data/transaction/model/transaction_history/transaction_history_response_model.dart';

import '../../../../../domain/domain.dart';
import '../transaction_status_mapping.dart';

extension TransactionHistoryResponseDataMapping on TransactionHistoryResultList {
  DetailedTransaction toDomain() {
    final responseData = DetailedTransaction(
        id: transactionId,
        status: TransactionStatusMapping.fromString(code: statusCode ?? '', value: status ?? ''),
        senderResult: DetailedTransactionSenderResult(
            name: Name(firstName: senderFirstName, lastName: senderLastName),
            currency: Catalog(id: "", value: currency ?? ""),
            realAmount: tradeAmount),
        receiverResult: TransactionReceiverResult(
            id: "",
            personalInfo: ReceiverPersonalInfo(
              fullName: '$beneficiaryFirstName $beneficiaryLastName',
              nameEnglish: Name(firstName: beneficiaryFirstName, lastName: beneficiaryLastName),
              nickName: transferNickname,
            ),
            payoutInfo: DetailedReceiverPayoutInfo(
              id: "",
              mode: PaymentMode(
                id: paymentType ?? "",
                value: paymentType ?? "",
                receiverCurrency: currency,
              ),
            )),
        calculationMode: null,
        totalAmountToPay: tradeAmount,
        currentRate: "",
        referenceNumber: referenceNumber,
        receiptTS: tradeTs,
        depositType: depositType,
        depositTypeName: depositTypeName,
        customerDeposited: "");
    return responseData;
  }
}
