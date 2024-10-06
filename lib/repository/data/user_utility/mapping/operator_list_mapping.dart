
import '../../../domain/user/entities/user_info/user_info.dart';

class OperatorListMapper {
  static DetailedUser fromJsonList(Map<String, dynamic> json) {
    List<String> nameParts =
        (json['user_full_name'] != null || json['user_full_name'].isNotEmpty) ? json['user_full_name'].split(' ') : [];
    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    String middleName = nameParts.length > 2 ? nameParts.sublist(1, nameParts.length - 1).join(' ') : '';
    String lastName = nameParts.length > 1 ? nameParts.last : '';

    final contactInfo = UserContactInfo(
      mobileNumber: json['phone_number'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      neighborhood: json['neighbourhood'],
      postalCode: json['postal_code'],
      createdTime: json['created_at'],
      emailAddress: json['email'],
    );
    final personalInfo = UserPersonalInfo(
      fullName: json['user_full_name'],
      userName: json['user_full_name'],
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
    );
    return DetailedUser(
      id: json['id']?.toString(),
      personalInfo: personalInfo,
      contactInfo: contactInfo,
    );
  }
}
