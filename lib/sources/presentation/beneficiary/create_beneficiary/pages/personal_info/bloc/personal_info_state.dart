part of 'personal_info_bloc.dart';

class PersonalInfoState extends Equatable {
  final String fullName;
  final bool isEdit;
  final Catalog? relation;
  final List<Catalog>? relationList;
  final bool isRelationOther;
  final String relationOtherDetail;
  final String phoneNumber;
  final FormStatus status;

  String? get fullNameValidation {
    List<String> nameParts = fullName.trim().split(" ");
    if (fullName != "" && nameParts.length >= 2) {
      return null;
    } else {
      return "Please enter beneficiary full name";
    }
  }

  String? get relationValidation =>
      (relation != null) ? null : LocaleKeys.relationshipErrorMessage.value;
  String? get otherRelationValidation => (relation?.id == AppConstants.other)
      ? (relationOtherDetail != "")
          ? null
          : "Please specify valid relation"
      : null;
  String? get phoneNumberValidation =>
      (phoneNumber != "") ? null : LocaleKeys.phoneNumberErrorMessage.value;

  PersonalInfoState({
    this.fullName = "",
    this.isEdit = false,
    this.relation,
    this.isRelationOther = false,
    this.relationOtherDetail = "",
    this.relationList,
    this.phoneNumber = "",
    status,
  }) : status = (status != null) ? status : InitialStatus();

  PersonalInfoState copyWith({
    String? fullName,
    String? firstName,
    String? middleName,
    String? lastName,
    bool? isEdit,
    Catalog? relation,
    String? relationOtherDetail,
    bool? isRelationOther,
    List<Catalog>? relationList,
    String? phoneNumber,
    FormStatus? status,
  }) {
    return PersonalInfoState(
      fullName: fullName ?? this.fullName,
      isEdit: isEdit ?? this.isEdit,
      relation: relation ?? this.relation,
      relationOtherDetail: relationOtherDetail ?? this.relationOtherDetail,
      isRelationOther: isRelationOther ?? this.isRelationOther,
      relationList: relationList ?? this.relationList,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? InitialStatus(),
    );
  }

  ReceiverPersonalInfo get personalData => _makePersonalData();

  ReceiverPersonalInfo _makePersonalData() {
    List<String> nameParts = fullName.trim().split(" ");
    String? firstName = "";
    String? middleName = "";
    String? lastName = "";

    if (nameParts.length == 1) {
      firstName = fullName;
    } else if (nameParts.length == 2) {
      firstName = nameParts[0];
      lastName = nameParts[1];
    } else if (nameParts.length >= 3) {
      firstName = nameParts[0];
      middleName = nameParts.sublist(1, nameParts.length - 1).join(' ');
      lastName = nameParts.last;
    }
    final name = Name(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
    );
    return ReceiverPersonalInfo(
      nameEnglish: name,
      fullName: fullName,
      mobile: phoneNumber,
      relation: relation,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        status,
        relation,
        relationList,
        isRelationOther,
        relationOtherDetail,
        phoneNumber,
      ];
}
