import 'package:fresh_fold_delivery/repository/data/transaction/model/upload_payment/upload_payment_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/transaction/entities/upload_payment/upload_payment_info.dart';

extension UploadPaymentRequestDataMapping on UploadPaymentInfo {
  UploadPaymentRequest toRequest() {
    final responseData = UploadPaymentRequest(
      tranno: tranno,
      receiptImage: receiptImage,
      depositBankId: depositBank?.id,
    );
    return responseData;
  }
}
