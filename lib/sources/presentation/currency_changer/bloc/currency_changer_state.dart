part of 'currency_changer_bloc.dart';

class CurrencyChangerState extends Equatable {
  final String? selectedCurrencyCode;
  final List<ReceivingCountry>? receivingCountryList;
  final FormStatus status;

  CurrencyChangerState({
    this.selectedCurrencyCode,
    this.receivingCountryList,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  CurrencyChangerState copyWith({
    String? selectedCurrencyCode,
    List<ReceivingCountry>? receivingCountryList,
    FormStatus? status,
  }) {
    return CurrencyChangerState(
      selectedCurrencyCode: selectedCurrencyCode ?? this.selectedCurrencyCode,
      receivingCountryList: receivingCountryList ?? this.receivingCountryList,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [selectedCurrencyCode, receivingCountryList, status];
}
