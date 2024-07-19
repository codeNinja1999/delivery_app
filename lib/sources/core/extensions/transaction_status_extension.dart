import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../resources/resources.dart';
import '../app_core.dart';

extension TransactionStatusColorExtension on TransactionType {
  HexColor get color => getValue();

  HexColor getValue() {
    switch (this) {
      case TransactionType.hold:
      case TransactionType.post:
        return AppColors.hold; //blue

      case TransactionType.cancelled:
      case TransactionType.error:
        return AppColors.cancelled; //red

      case TransactionType.paymentReview:
      case TransactionType.pendingPayment:
      case TransactionType.unknown:
        return AppColors.pending; //yellow

      case TransactionType.paid:
        return AppColors.success; //green

      default:
        return AppColors.hold; // green
    }
  }
}
