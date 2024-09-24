import 'package:fresh_fold_delivery/repository/domain/domain.dart';

import '../../../domain/operator/entities/operator_entities.dart';

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
  static DetailedOperator fromJsonList(Map<String, dynamic> json) {
    return DetailedOperator(
      id: json['id']?.toString(),
      fullName: json['user_full_name'],
      phoneCode: json['phone_code'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      neighborhood: json['neighbourhood'],
      postalCode: json['postal_code'],
      status: json['status'],
      createdAt: json['created_at'],
      emailAddress: json['email'],
      password: json['password'],
      confirmPassword: json['confirm_password'],
    );
  }

}
