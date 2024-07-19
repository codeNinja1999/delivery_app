// ignore_for_file: unnecessary_import

import 'package:fresh_fold_delivery/repository/domain/otp/entities/verify_by.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

extension OTPIssuTypeValue on OTPIssueType {
  String value(VerifyBy verifyBy) => getValue(verifyBy);

  String getValue(VerifyBy verifyBy) {
    switch (this) {
      case OTPIssueType.resetPassword:
        return "01";
      case OTPIssueType.register:
        return verifyBy == VerifyBy.email ? "02" : "07";
      case OTPIssueType.emailAuthentication:
        return "03";
      case OTPIssueType.resetTransactionPin:
        return "04";
      case OTPIssueType.webOnlineMemberRegistration:
        return "05";

      case OTPIssueType.newDevice:
        return "NewDevice";
    }
  }
}
