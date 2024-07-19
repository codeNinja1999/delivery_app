import 'package:fresh_fold_delivery/repository/data/transaction/model/transaction_detail/transaction_detail_response_model.dart';
import 'package:fresh_fold_delivery/repository/data/transaction/repository/mapping/transaction_status_mapping.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

extension TransactionDetailReponseMapping on TransactionDetailResponseModel {
  DetailedTransaction toDomain() {
    final responseData = DetailedTransaction(
      id: transactionId,
      status: TransactionStatusMapping.fromString(code: statusCode ?? '', value: status ?? ''),
      senderResult: DetailedTransactionSenderResult(
          name: Name(firstName: senderFirstName, lastName: senderLastName),
          currency: Catalog(id: exchangeBaseCurrencyCode ?? "", value: exchangeBaseCurrencyCode ?? ""),
          realAmount: sendAmount),
      receiverResult: TransactionReceiverResult(
        id: "",
        contactInfo:
            ReceiverContactInfo(receivingCountry: ReceivingCountry(id: receiverCountry ?? "", value: receiverCountry ?? "")),
        personalInfo: ReceiverPersonalInfo(
          fullName: StringFormatUtils.mergeNames(
            EnglishName(
              firstName: beneficiaryFirstName,
              middleName: beneficiaryMiddleName,
              lastName: beneficiaryLastName,
            ),
          ),
          nameEnglish: Name(
            firstName: beneficiaryFirstName,
            middleName: beneficiaryMiddleName,
            lastName: beneficiaryLastName,
          ),
          nickName: beneficiaryTransferNickname,
          address: address,
        ),
        payoutInfo: DetailedReceiverPayoutInfo(
          id: transactionId,
          mode: PaymentMode(
            id: deliveryMethod ?? "",
            value: deliveryMethod ?? "",
            receiverCurrency: exchangeCounterCurrencyCode,
          ),
          currency: Catalog(
            id: exchangeCounterCurrencyCode ?? "",
            value: exchangeCounterCurrencyCode ?? "",
          ),
          bank: Bank(
            id: "",
            value: paymentInfo ?? "",
            methodCode: deliveryMethod ?? "",
          ),
          //branch: bankBranch,
          branch: Branch(id: bankBranch ?? "", value: bankBranch ?? ""),
          accountNumber: bankAccount,
        ),
        realAmount: deliveryAmount,
        promptPayQR: promptPayQR,
        bankaccountName: bankaccountName,
        bankaccountNumber: bankaccountNumber,
      ),
      calculationMode: null,
      totalAmountToPay: collectedAmount,
      currentRate: exchangeRate,
      referenceNumber: referenceNumber,
      receiptTS: tradeTs,
      customerDeposited: depositedDate,
      discountFee: bonusAmt,
      taxAmount: taxAmount,
      serviceFee: transferFee,
      receiptImage: receiptImage,
      depositType: depositType,
    );
    return responseData;
  }
}
