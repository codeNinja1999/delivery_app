import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class UserPersonalInfoViewModel {
  final String? fullName;
  final String? mobileNumber;
  final String? nationality;
  final String? gender;
  final String? dob;
  final String? address;
  final String? emailAddress;
  final String? profileImageUrl;
  final KYCStatus? status;
  final String? state;
  final String? city;
  final String? zipCode;
  final String? country;
  final String? flag;
  final String? idType;
  final String? idNumber;
  final String? issueCountry;
  final String? issueDate;
  final String? expiryDate;
  final String? username;

  UserPersonalInfoViewModel({
    this.fullName,
    this.mobileNumber,
    this.nationality,
    this.gender,
    this.dob,
    this.address,
    this.emailAddress,
    this.profileImageUrl,
    this.status,
    this.state,
    this.city,
    this.zipCode,
    this.country,
    this.flag,
    this.idType,
    this.idNumber,
    this.issueCountry,
    this.issueDate,
    this.expiryDate,
    this.username,
  });

  factory UserPersonalInfoViewModel.fromTransaction(DetailedUser? data) {
    return UserPersonalInfoViewModel(
      fullName: data?.personalInfo.fullName,
      mobileNumber: data?.contactInfo?.mobileNumber,
      nationality: data?.personalInfo.nationality?.value,
      country: data?.contactInfo?.country?.value,
      gender: data?.personalInfo.gender?.value,
      dob: data?.personalInfo.dateOfBirth,
      address: data?.contactInfo?.streetAddress,
      emailAddress: data?.contactInfo?.emailAddress,
      profileImageUrl: data?.userImage?.customerProfileImage ?? data?.userImage?.customerSelfieImage,
      status: data?.status ?? KYCStatus.pending,
      state: data?.contactInfo!.state?.value,
      city: data?.contactInfo?.city?.value,
      zipCode: data?.contactInfo?.postalCode,
      idType: data?.identificationInfo?.idType?.value,
      idNumber: data?.identificationInfo?.idNumber,
      issueDate: data?.identificationInfo?.issuedDate,
      issueCountry: data?.identificationInfo?.issuedCountry?.value,
      expiryDate: data?.identificationInfo?.expiryDate,
      flag: "${AppConstants.countryImageUrl}${(data?.personalInfo.nationality?.id ?? "NPL").toLowerCase()}.svg",
      username: data?.userName,
    );
  }
}
