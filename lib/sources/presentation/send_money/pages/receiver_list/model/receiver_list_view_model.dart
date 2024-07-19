import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

class ReceiverListViewModel {
  final KYCStatus? userStatus;
  final DetailedReceiver? receiver;
  final String title;
  final DetailedReceiver? detailedReceiver;
  final String? beneficiaryId;
  final String? subTitle;
  final String? heading;
  final String? subHeading;
  final String? receiverFlag;
  final bool isDisabledBeneficiary;

  ReceiverListViewModel({
    this.userStatus,
    this.receiver,
    this.beneficiaryId,
    this.detailedReceiver,
    this.title = "",
    this.subTitle,
    this.heading,
    this.subHeading,
    this.receiverFlag,
    this.isDisabledBeneficiary = false,
  });

  factory ReceiverListViewModel.fromReceiver({
    DetailedReceiver? detailedReceiver,
    bool isDisabledBeneficiary = false,
  }) {
    return ReceiverListViewModel(
      detailedReceiver: detailedReceiver,
      beneficiaryId: detailedReceiver?.id ?? "",
      title: detailedReceiver?.personalInfo?.fullName ?? "",
      receiverFlag:
          "${AppConstants.countryImageUrl}${detailedReceiver?.defaultPayoutInfo?.receivingCountry?.id.toLowerCase()}.svg",
      subTitle: detailedReceiver?.defaultPayoutInfo?.receivingCountry?.value ?? "",
      isDisabledBeneficiary: isDisabledBeneficiary,
    );
  }

  ReceiverListViewModel userStatusUpdated({required KYCStatus? userStatus}) {
    return ReceiverListViewModel(
      userStatus: userStatus ?? this.userStatus,
      receiver: receiver,
      title: title,
      subTitle: subTitle,
      receiverFlag: receiverFlag,
    );
  }
}
