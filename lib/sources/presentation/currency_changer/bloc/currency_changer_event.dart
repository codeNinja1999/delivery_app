part of 'currency_changer_bloc.dart';

abstract class CurrencyChangerEvent {}

class GetReceivingCountry extends CurrencyChangerEvent {}

class GetSelectedCurrencyCode extends CurrencyChangerEvent {}
