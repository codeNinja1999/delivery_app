part of 'beneficiary_list_bloc.dart';

class BeneficiaryListState extends Equatable {
  final List<BeneficiaryListViewModel>? defaultReceiverList;
  final List<BeneficiaryListViewModel> receiverList;
  final FormStatus status;

  BeneficiaryListState({
    this.defaultReceiverList,
    receiverList,
    status,
  })  : receiverList = (receiverList != null) ? receiverList : [],
        status = (status != null) ? status : InitialStatus();

  BeneficiaryListState copyWith({
    List<BeneficiaryListViewModel>? defaultReceiverList,
    List<BeneficiaryListViewModel>? receiverList,
    FormStatus? status,
  }) {
    return BeneficiaryListState(
      defaultReceiverList: defaultReceiverList ?? this.defaultReceiverList,
      receiverList: receiverList ?? this.receiverList,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [defaultReceiverList, receiverList, status];
}
