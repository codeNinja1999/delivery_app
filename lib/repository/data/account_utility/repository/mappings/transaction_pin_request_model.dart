import 'package:fresh_fold_delivery/repository/data/account_utility/model/change_transaction_pin/change_transaction_pin_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/account_utility/entities/change_transaction_pin.dart';

extension ChangeTransactionPinRequestDataMapping on ChangeTradePinInfo {
  ChangeTransactionPinRequestModel toRequestData() {
    final requestData = ChangeTransactionPinRequestModel(
      currentPin: currentPin,
      newPin: newPin,
      useAsLoginPassword: "useAsLoginPassword",
      issueType: issueType,
      processId: processID,
    );
    return requestData;
  }
}
