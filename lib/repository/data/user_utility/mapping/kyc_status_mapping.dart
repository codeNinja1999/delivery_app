import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/kyc_status.dart';

KYCStatus status(String value) => fromString(value: value);

KYCStatus fromString({required String value}) {
  switch (value.toLowerCase()) {
    case "y":
      return KYCStatus.verified;
    case "p":
      return KYCStatus.submitted;
    case "v":
      return KYCStatus.partial;
    case "r":
      return KYCStatus.rejected;
    case "e":
      return KYCStatus.expired;
    default:
      return KYCStatus.pending;
  }
}
