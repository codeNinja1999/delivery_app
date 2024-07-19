import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

enum PaymentMenuItemType { heading, list }

class BeneficiaryListViewModel {
  final KYCStatus? userStatus;
  final String? beneficiaryName;
  final DetailedReceiver? receiver;
  final String title;
  final String? subTitle;
  final PaymentMenuItemType itemType;
  final String receiverFlag;

  BeneficiaryListViewModel({
    this.userStatus,
    this.beneficiaryName,
    this.receiver,
    required this.title,
    this.subTitle,
    required this.itemType,
    this.receiverFlag = AppConstants.defaultFlagUrl,
  });

  factory BeneficiaryListViewModel.fromReceiver({
    required DetailedReceiver data,
    required String title,
    required PaymentMenuItemType itemType,
  }) {
    return BeneficiaryListViewModel(
      beneficiaryName: data.personalInfo?.fullName ?? "",
      receiver: data,
      title: title,
      subTitle: data.defaultPayoutInfo?.bank?.value ?? "",
      itemType: itemType,
      receiverFlag: (data.defaultPayoutInfo?.receivingCountry?.id != "")
          ? "${AppConstants.countryImageUrl}${data.defaultPayoutInfo?.receivingCountry?.id.toLowerCase()}.svg"
          : AppConstants.defaultFlagUrl,
    );
  }
}
