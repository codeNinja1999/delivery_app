import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class BeneficiaryDetailViewModel {
  final String avatarLabel;
  final String username;
  final String emailAddress;
  final String relationship;
  final String contactNumber;
  final String idType;
  final String gender;
  final String idNumber;
  final String? countryCode;
  final String zipCode;
  final Catalog? city;
  final Catalog? state;
  final String address;
  final String payoutMethod;
  final String bank;
  final String branchName;
  final String branchCode;
  final String accountNumber;
  final String countryName;
  final String flagUrl;

  final DetailedReceiver data;

  BeneficiaryDetailViewModel({
    required this.avatarLabel,
    required this.username,
    required this.emailAddress,
    required this.relationship,
    required this.contactNumber,
    required this.address,
    required this.idType,
    required this.gender,
    required this.idNumber,
    required this.zipCode,
    required this.countryCode,
    required this.countryName,
    required this.payoutMethod,
    required this.bank,
    required this.branchName,
    required this.branchCode,
    required this.accountNumber,
    required this.flagUrl,
    required this.data,
    this.state,
    this.city,
  });

  factory BeneficiaryDetailViewModel.fromDetailReceiver(DetailedReceiver data) => BeneficiaryDetailViewModel(
        avatarLabel: data.personalInfo?.fullName?.getInitials() ?? "GN",
        username: data.personalInfo?.fullName ?? "",
        emailAddress: data.contactInfo?.emailAddress ?? "",
        relationship: (data.personalInfo?.relation?.id == AppConstants.other)
            ? data.personalInfo?.relationAlternative ?? ""
            : data.personalInfo?.relation?.value ?? "",
        contactNumber: data.contactInfo?.mobileNumber ?? "",
        idType: data.identificationInfo?.idType.value ?? "",
        idNumber: data.identificationInfo?.idNumber ?? "",
        zipCode: data.contactInfo?.postalCode ?? "",
        state: data.contactInfo?.state,
        gender: data.personalInfo?.gender?.value ?? "",
        city: data.contactInfo?.city,
        address: data.contactInfo?.address2 ?? "",
        payoutMethod: data.defaultPayoutInfo?.mode?.value ?? "",
        bank: data.defaultPayoutInfo?.headOffice?.value ?? "",
        branchName: data.defaultPayoutInfo?.branch?.value ?? "",
        branchCode: data.defaultPayoutInfo?.branch?.id ?? "",
        accountNumber: data.defaultPayoutInfo?.accountNumber ?? "",
        countryCode: data.defaultPayoutInfo?.receivingCountry?.id ?? "",
        countryName: data.defaultPayoutInfo?.receivingCountry?.value ?? "",
        flagUrl: "${AppConstants.countryImageUrl}${data.defaultPayoutInfo?.receivingCountry?.id.toLowerCase() ?? ""}.svg",
        data: data,
      );
}
