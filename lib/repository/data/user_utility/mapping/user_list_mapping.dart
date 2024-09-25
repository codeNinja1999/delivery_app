import 'package:fresh_fold_delivery/repository/domain/domain.dart';

class UserMapper {
  static DetailedUser fromJson(Map<String, dynamic> json) {
    return DetailedUser(
      id: json['id']?.toString(),
      personalInfo: UserPersonalInfo(
        fullName: json['user_full_name'],
        email: json['email'],
        phoneCode: json['phone_code'],
        phoneNumber: json['phone_number'],
      ),
      contactInfo: UserContactInfo(
        id: json['id']?.toString(),
        createdTime: json['created_at'],
        postalCode: json['postal_code'],
        city: json['city'],
        neighborhood: json['neighbourhood'],
        houseNumber: json['house_number'],
        emailAddress: json['email'],
        mobileNumber: json['phone_number'],
      ),
      additionalInformation: "",
    );
  }
}
