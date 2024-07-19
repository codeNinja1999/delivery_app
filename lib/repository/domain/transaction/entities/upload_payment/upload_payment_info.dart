import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';

class UploadPaymentInfo {
  final String? receiptImage;
  final String? tranno;
  final DepositBank? depositBank;

  UploadPaymentInfo({this.receiptImage, this.tranno, this.depositBank});
}
