import '../../../domain/user/entities/operator/operator_entities.dart';

class OperatorListMapper {
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
