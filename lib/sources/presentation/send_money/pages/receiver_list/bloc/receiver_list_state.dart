part of 'receiver_list_bloc.dart';

class ReceiverListState extends Equatable {
  final PaymentMode? paymentMode;
  final ReceivingCountry? receivingCountry;
  final DetailedReceiver? selectedBeneficiary;
  final List<DetailedReceiver>? defaultReceiverList;
  final List<DetailedReceiver>? receiverList;
  final List<ReceiverListViewModel>? defaultReceiverListViewModel;
  final List<ReceiverListViewModel> receiverListViewModel;
  final String searchText;
  final FormStatus status;

  String? get beneficiaryValidation => (selectedBeneficiary != null)
      ? null
      : LocaleKeys.selectReceiverErrorMessage.value;
  ReceiverListState({
    this.paymentMode,
    this.receivingCountry,
    this.selectedBeneficiary,
    this.defaultReceiverList,
    this.receiverList,
    this.defaultReceiverListViewModel,
    this.receiverListViewModel = const [],
    this.searchText = "",
    status,
  }) : status = (status != null) ? status : InitialStatus();

  ReceiverListState copyWith({
    PaymentMode? paymentMode,
    ReceivingCountry? receivingCountry,
    List<DetailedReceiver>? defaultReceiverList,
    List<DetailedReceiver>? receiverList,
    DetailedReceiver? selectedBeneficiary,
    List<ReceiverListViewModel>? receiverListViewModel,
    List<ReceiverListViewModel>? nepalOnlyList,
    List<ReceiverListViewModel>? otherCountryList,
    List<ReceiverListViewModel>? defaultReceiverListViewModel,
    String? searchText,
    FormStatus? status,
  }) {
    final state = ReceiverListState(
      paymentMode: paymentMode ?? this.paymentMode,
      receivingCountry: receivingCountry ?? this.receivingCountry,
      selectedBeneficiary: selectedBeneficiary ?? this.selectedBeneficiary,
      defaultReceiverList: defaultReceiverList ?? this.defaultReceiverList,
      receiverListViewModel:
          receiverListViewModel ?? this.receiverListViewModel,
      receiverList: ((receiverList?.length ?? -1) == 0)
          ? null
          : receiverList ?? this.receiverList,
      defaultReceiverListViewModel:
          defaultReceiverListViewModel ?? this.defaultReceiverListViewModel,
      searchText: searchText ?? this.searchText,
      status: status ?? InitialStatus(),
    );
    return state;
  }

  @override
  List<Object?> get props => [
        paymentMode,
        receivingCountry,
        selectedBeneficiary,
        defaultReceiverList,
        receiverListViewModel,
        receiverList,
        searchText,
        defaultReceiverListViewModel,
        status,
      ];
}
