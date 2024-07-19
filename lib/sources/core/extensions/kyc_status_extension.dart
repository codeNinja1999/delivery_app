import 'package:flutter/material.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../../../repository/repository.dart';

extension KycStatusExtension on KYCStatus {
  String get value {
    switch (this) {
      case KYCStatus.pending:
        return LocaleKeys.pending.value;
      case KYCStatus.submitted:
        return LocaleKeys.processing.value;
      case KYCStatus.verified:
        return LocaleKeys.verified.value;
      case KYCStatus.rejected:
        return LocaleKeys.rejected.value;
      case KYCStatus.expired:
        return LocaleKeys.expired.value;
      case KYCStatus.partial:
        return LocaleKeys.partial.value;
    }
  }

  Color get color {
    switch (this) {
      case KYCStatus.verified:
        return Colors.green.shade100;
      case KYCStatus.pending:
      case KYCStatus.submitted:
        return Colors.blue.shade100;
      case KYCStatus.rejected:
      case KYCStatus.expired:
        return Colors.red.shade100;
      default:
        return Colors.yellow.shade500;
    }
  }

  Color get textColor {
    switch (this) {
      case KYCStatus.verified:
        return Colors.green.shade900;
      case KYCStatus.pending:
      case KYCStatus.submitted:
        return Colors.blue.shade900;
      case KYCStatus.rejected:
      case KYCStatus.expired:
        return Colors.red.shade900;
      default:
        return Colors.yellow.shade900;
    }
  }
}
