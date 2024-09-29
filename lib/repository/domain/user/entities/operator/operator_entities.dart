class Operator {
  final String? fullName;
  final String? phoneNumber;
  final String? address;
  final String? emailAddress;
  final String? password;
  final String? confirmPassword;

  Operator({
    this.fullName,
    this.address,
    this.emailAddress,
    this.phoneNumber,
    this.password,
    this.confirmPassword,
  });
}

class DetailedOperator {
  final String? id;
  final String? fullName;
  final String? phoneCode;
  final String? phoneNumber;
  final String? address;
  final String? city;
  final String? country;
  final String? neighborhood;
  final String? postalCode;
  final String? status;
  final String? createdAt;
  final String? emailAddress;
  final String? password;
  final String? confirmPassword;


  DetailedOperator({
    this.id,
    this.fullName,
    this.phoneCode,
    this.phoneNumber,
    this.address,
    this.city,
    this.country,
    this.neighborhood,
    this.postalCode,
    this.status,
    this.createdAt,
    this.emailAddress,
    this.password,
    this.confirmPassword,
  });
}
