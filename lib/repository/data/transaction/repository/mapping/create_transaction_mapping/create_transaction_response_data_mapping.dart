import 'package:fresh_fold_delivery/repository/data/transaction/model/create_transaction/create_transaction_response_model.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

extension CreateTransactionResponseDataMapping on CreateTransactionResponse {
  CreateTransactionResult toDomain(CreateTransactionInfo info) {
    final fullName =
        "${remittanceInfo?.beneficiary?.nameEnglish?.firstName ?? ""} ${remittanceInfo?.beneficiary?.nameEnglish?.middleName ?? ""} ${remittanceInfo?.beneficiary?.nameEnglish?.lastName ?? ""}";

    final receiverPayoutInfo = DetailedReceiverPayoutInfo(
      bank: Bank(
          id: remittanceInfo?.beneficiary?.beneficiaryDetail?.bankCode ?? "",
          value: remittanceInfo?.beneficiary?.beneficiaryDetail?.bankName ?? "",
          methodCode: remittanceInfo?.beneficiary?.beneficiaryDetail?.remittanceMethodCode ?? ""),
      accountNumber: remittanceInfo?.beneficiary?.beneficiaryDetail?.accountNumber,
      //branch: remittanceInfo?.beneficiary?.beneficiaryDetail?.branchName,
      receivingCountry: ReceivingCountry(
          id: remittanceInfo?.beneficiary?.beneficiaryDetail?.countryCode ?? "",
          value: remittanceInfo?.beneficiary?.beneficiaryDetail?.countryName ?? ""),
      branch: Branch(
          id: remittanceInfo?.beneficiary?.beneficiaryDetail?.branchCode ?? "",
          value: remittanceInfo?.beneficiary?.beneficiaryDetail?.branchName ?? ""),
      mode: PaymentMode(
        id: remittanceInfo?.beneficiary?.beneficiaryDetail?.remittanceMethodCode ?? "",
        value: remittanceInfo?.beneficiary?.beneficiaryDetail?.remittanceMethodName ?? "",
        receiverCurrency: remittanceInfo?.beneficiary?.beneficiaryDetail?.countryCode,
      ),
      currency: Catalog(
          id: remittanceInfo?.beneficiary?.beneficiaryDetail?.receiveCurrencyCode ?? "",
          value: remittanceInfo?.beneficiary?.beneficiaryDetail?.receiveCurrencyCode ?? ""),
    );

    final name = Name(
        firstName: remittanceInfo?.beneficiary?.nameEnglish?.firstName ?? "",
        middleName: remittanceInfo?.beneficiary?.nameEnglish?.middleName ?? "",
        lastName: remittanceInfo?.beneficiary?.nameEnglish?.lastName ?? "");

    final responseData = CreateTransactionResult(
        id: remittanceInfo?.transactionId,
        createdDate: remittanceInfo?.lastUpdateTs,
        promptPayQr: remittanceInfo?.promptPayQr,
        senderResult: TransactionSenderResult(
          country: info.senderInfo?.country,
          currency: Catalog(
              id: remittanceInfo?.beneficiary?.beneficiaryDetail?.receiveCurrencyCode ?? "",
              value: remittanceInfo?.beneficiary?.beneficiaryDetail?.receiveCurrencyCode ?? ""),
          depositMode:
              DepositType(id: remittanceInfo?.depositMethodCode ?? "", value: remittanceInfo?.depositMethodCode ?? ""),
          realAmount: remittanceInfo?.remittanceAmount,
        ),
        receiverResult: TransactionReceiverResult(
            id: info.receiverInfo?.id,
            personalInfo: ReceiverPersonalInfo(fullName: fullName, nameEnglish: name),
            payoutInfo: receiverPayoutInfo,
            realAmount: remittanceInfo?.receivingAmount),
        calculationMode: null,
        serviceFee: remittanceInfo?.remittanceFee ?? "",
        discountFee: null,
        totalAmountToPay: remittanceInfo?.totalAmount ?? "",
        currentRate: remittanceInfo?.exchangeRate ?? "",
        balance: "",
        taxAmount: remittanceInfo?.taxAmount ?? "");
    return responseData;
  }
}
