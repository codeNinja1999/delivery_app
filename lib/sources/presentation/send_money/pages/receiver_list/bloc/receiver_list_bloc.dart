import 'dart:async';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import '../model/receiver_list_view_model.dart';

part 'receiver_list_event.dart';
part 'receiver_list_state.dart';

class ReceiverListBloc extends Bloc<ReceiverListEvent, ReceiverListState> {
  final ReceiverRepository receiverRepository;
  final CatalogRepository catalogRepository;
  final TransactionActivityRepository transactionActivityRepository;
  ReceiverListBloc({
    required this.receiverRepository,
    required this.catalogRepository,
    required this.transactionActivityRepository,
  }) : super(ReceiverListState()) {
    on<GetReceiverList>((event, emit) async => await receiverRepository.getReceiverList());
    on<BeneficiaryListsSubscriptionRequested>(_onBeneficiaryListsSubscriptionRequested);
    on<BeneficiarySelected>((event, emit) => emit(state.copyWith(selectedBeneficiary: event.beneficiary)));
    on<GetPaymentMode>((event, emit) {
      emit(state.copyWith(paymentMode: event.paymentMode, receivingCountry: event.receivingCountry));
      add(GetReceiverList());
      add(BeneficiaryListsSubscriptionRequested());
    });

    on<BeneficiaryDetails>(
      ((event, emit) async {
        final response = await receiverRepository.getReceiverDetail(event.beneficiaryID);
        emit(
          response.fold(
            (error) => state.copyWith(status: SubmissionFailure(error)),
            (data) => state.copyWith(selectedBeneficiary: data),
          ),
        );
      }),
    );
    on<SearchTextChanged>(_onSearchFilter);
  }
  _onSearchFilter(
    SearchTextChanged event,
    Emitter<ReceiverListState> emit,
  ) {
    List<ReceiverListViewModel>? filteredReceiverList = [];
    emit(state.copyWith(searchText: event.searchString));
    if (event.searchString == "") {
      filteredReceiverList = state.defaultReceiverListViewModel;
    } else {
      filteredReceiverList = (state.defaultReceiverListViewModel != null)
          ? state.defaultReceiverListViewModel
              ?.where(
                (receiver) => receiver.title.toLowerCase().contains(event.searchString!.toLowerCase()),
              )
              .toList()
          : [];
    }
    emit(state.copyWith(receiverListViewModel: filteredReceiverList));
  }

  FutureOr<void> _onBeneficiaryListsSubscriptionRequested(
    BeneficiaryListsSubscriptionRequested event,
    Emitter<ReceiverListState> emit,
  ) async {
    await emit.forEach<List<DetailedReceiver>?>(
      receiverRepository.receiverList(),
      onData: (receiverList) {
        List<ReceiverListViewModel> list = [];

        if (receiverList != null && receiverList.isNotEmpty) {
          final beneficiaryFilter = receiverList.where((element) =>
              (element.contactInfo?.receivingCountry.id == state.receivingCountry?.id &&
                  element.defaultPayoutInfo?.mode?.id == state.paymentMode?.id));
          final otherCountryFilter = receiverList.where((element) =>
              element.contactInfo?.receivingCountry.id != state.receivingCountry?.id &&
              element.defaultPayoutInfo?.mode?.id == state.paymentMode?.id);

          if (beneficiaryFilter.isNotEmpty || otherCountryFilter.isNotEmpty) {
            list.add(ReceiverListViewModel(heading: "Beneficiary in ${state.receivingCountry?.value}"));
            list.add(ReceiverListViewModel(subHeading: LocaleKeys.selectBeneficiaryFromReceivingCountry.value));
            list.addAll(
              beneficiaryFilter.map((beneficiary) => ReceiverListViewModel.fromReceiver(detailedReceiver: beneficiary)),
            );
            list.add(ReceiverListViewModel(heading: LocaleKeys.otherBeneficiaries.value));
            list.addAll(
              otherCountryFilter.map(
                (otherBeneficiary) => ReceiverListViewModel.fromReceiver(
                  detailedReceiver: otherBeneficiary,
                  isDisabledBeneficiary: true,
                ),
              ),
            );
            return state.copyWith(
              receiverList: receiverList,
              receiverListViewModel: list,
              defaultReceiverListViewModel: list,
            );
          } else {
            return state;
          }
        } else {
          return state;
        }
      },
      onError: (error, __) {
        return state;
      },
    );
  }
}
