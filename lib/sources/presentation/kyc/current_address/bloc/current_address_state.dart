part of 'current_address_bloc.dart';

class CurrentAddressState extends Equatable {
  final String streetAddress;
  final String zipCode;
  final String city;
  final String? state;
  final String japaneseSenderAddress;
  final String japaneseStreetAddress;
  final List<Catalog>? stateList;
  final List<PostalAddress>? postalAddressList;

  final FormStatus status;

  String? get streetAddressValidation => (streetAddress != "") ? null : LocaleKeys.locationErrorMessage.value;
  String? get japaneseStreetAddressValidation =>
      (japaneseStreetAddress != "") ? null : LocaleKeys.streetAddressErrorMessage.value;
  String? get japaneseSenderAddressValidation => (japaneseSenderAddress != "") ? null : "Please enter sender address";
  String? get cityValidation => (city != "") ? null : LocaleKeys.cityErrorMessage.value;
  String? get zipCodeValidation => (zipCode != "") ? null : LocaleKeys.zipCodeErrorMessage.value;
  String? get stateValidation => (state != "") ? null : LocaleKeys.stateErrorMessage.value;

  CurrentAddressState({
    this.streetAddress = "",
    this.zipCode = "",
    this.city = "",
    this.state = "",
    this.japaneseSenderAddress = "",
    this.japaneseStreetAddress = "",
    this.stateList,
    this.postalAddressList,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  CurrentAddressState copyWith({
    String? streetAddress,
    String? zipCode,
    String? city,
    String? state,
    String? japaneseSenderAddress,
    String? japaneseStreetAddress,
    List<PostalAddress>? postalAddressList,
    FormStatus? status,
  }) {
    return CurrentAddressState(
      streetAddress: streetAddress ?? this.streetAddress,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      state: state ?? this.state,
      japaneseStreetAddress: japaneseStreetAddress ?? this.japaneseStreetAddress,
      japaneseSenderAddress: japaneseSenderAddress ?? this.japaneseSenderAddress,
      postalAddressList: postalAddressList ?? this.postalAddressList,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        streetAddress,
        city,
        zipCode,
        postalAddressList,
        japaneseSenderAddress,
        japaneseStreetAddress,
        state,
        status,
      ];
}
