part of 'personal_information_bloc.dart';

class PersonalInformationState extends Equatable {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String dateOfBirth;
  final Country? nationality;
  final Catalog? occupation;
  final Catalog? gender;
  final Catalog? idVisaType;
  final List<Catalog>? idVisaTypeList;
  final String? occupationOther;
  final List<Catalog>? occupationList;
  final List<Country>? nationalityList;
  final List<Country>? countryList;
  final FormStatus status;

  String? get firstNameValidation => (firstName != "") ? null : LocaleKeys.firstNameErrorMessage.value;
  String? get lastNameValidation => (lastName != "") ? null : LocaleKeys.lastNameErrorMessage.value;
  String? get idVisaTypeValidation => (idVisaType != null) ? null : LocaleKeys.visaTypeErrorMessage.value;
  String? get dobValidation => (dateOfBirth != "") ? null : LocaleKeys.dobErrorMessage.value;
  String? get genderValidation => (gender != null) ? null : LocaleKeys.genderErrorMessage.value;
  String? get nationalityValidation => (nationality != null) ? null : LocaleKeys.nationalityErrorMessage.value;
  String? get occupationValidation => (occupation != null) ? null : LocaleKeys.occupationErrorMessage.value;
  String? get occupationOtherValidation => (occupation?.id == AppConstants.others)
      ? (occupationOther != "")
          ? null
          : "Please enter occupation"
      : null;

  PersonalInformationState({
    this.firstName = "",
    this.middleName,
    this.lastName = "",
    this.idVisaType,
    this.idVisaTypeList,
    this.dateOfBirth = "",
    this.occupationOther = "",
    this.gender,
    this.nationality,
    this.countryList,
    this.nationalityList,
    this.occupation,
    this.occupationList,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  PersonalInformationState copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? dateOfBirth,
    Country? nationality,
    FormStatus? status,
    Catalog? idVisaType,
    List<Catalog>? idVisaTypeList,
    DetailedUser? userInfo,
    Catalog? occupation,
    Catalog? gender,
    String? occupationOther,
    List<Catalog>? occupationList,
    List<Country>? countryList,
    List<Country>? nationalityList,
  }) {
    return PersonalInformationState(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      idVisaType: idVisaType ?? this.idVisaType,
      idVisaTypeList: idVisaTypeList ?? this.idVisaTypeList,
      occupationList: occupationList ?? this.occupationList,
      occupationOther: occupationOther ?? this.occupationOther,
      occupation: occupation ?? this.occupation,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      nationality: nationality ?? this.nationality,
      countryList: countryList ?? this.countryList,
      nationalityList: nationalityList ?? this.nationalityList,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        dateOfBirth,
        nationality,
        gender,
        idVisaType,
        idVisaTypeList,
        status,
        countryList,
        nationalityList,
      ];

  final List<Catalog> genderList = const <Catalog>[
    Catalog(id: "M", value: "Male"),
    Catalog(id: "F", value: "Female"),
    Catalog(id: "O", value: AppConstants.other),
  ];
}
