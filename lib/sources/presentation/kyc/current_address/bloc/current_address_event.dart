part of 'current_address_bloc.dart';

abstract class CurrentAddressEvent {}

class GetState extends CurrentAddressEvent {}

class SearchPostalAddress extends CurrentAddressEvent {}

class PostalAddressSelected extends CurrentAddressEvent {
  PostalAddressSelected(this.postalAddress);
  final PostalAddress? postalAddress;
}

class CityChanged extends CurrentAddressEvent {
  CityChanged(this.city);
  final String city;
}

class StreetAddressChanged extends CurrentAddressEvent {
  StreetAddressChanged(this.streetAddress);
  final String streetAddress;
}

class JapaneseSenderAddressChanged extends CurrentAddressEvent {
  JapaneseSenderAddressChanged(this.japaneseSenderAddress);
  final String japaneseSenderAddress;
}

class JapaneseStreetAddressChanged extends CurrentAddressEvent {
  JapaneseStreetAddressChanged(this.japaneseStreetAddressChanged);
  final String japaneseStreetAddressChanged;
}

class StateSelected extends CurrentAddressEvent {
  StateSelected(this.state);
  final String state;
}

class ZipCodeChanged extends CurrentAddressEvent {
  ZipCodeChanged(this.zipCode);
  final String zipCode;
}

class CurrentAddressSubscriptionRequested extends CurrentAddressEvent {}
