class NameEnglish {
  NameEnglish({
    this.firstName,
    this.middleName,
    this.lastName,
    this.lastName2,
  });

  String? firstName;
  String? middleName;
  String? lastName;
  String? lastName2;

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "last_name2": lastName2,
      };

  factory NameEnglish.fromJson(Map<String, dynamic> json) => NameEnglish(
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        lastName2: json["last_name2"],
      );
}
