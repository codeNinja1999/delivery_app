import 'package:fresh_fold_delivery/repository/data/transaction/model/transaction_history/transaction_history_request_model.dart';

import '../../../../../domain/transaction/entities/entities.dart';

extension TransactionHistoryRequestDataMapping on TransactionListFilter {
  TransactionHistoryRequest toRequest() {
    final requestData = TransactionHistoryRequest(
        pageNo: pageNumber, displayDataNo: itemCount, tradeFormDate: startDate, tradeToDate: endDate, issueType: issueType);
    return requestData;
  }
}
