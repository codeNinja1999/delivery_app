part of 'beneficiary_list_bloc.dart';

abstract class BeneficiaryListEvent {}

class GetBeneficiaryList extends BeneficiaryListEvent {}

class UserInfoSubscriptionRequested extends BeneficiaryListEvent {}

class BeneficiaryListSubscriptionRequested extends BeneficiaryListEvent {}

class GetLinkedBankChannelList extends BeneficiaryListEvent {}

class SearchTextChanged extends BeneficiaryListEvent {
  final String? searchString;
  SearchTextChanged(this.searchString);
}

