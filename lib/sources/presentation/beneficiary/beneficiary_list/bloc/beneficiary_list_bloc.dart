import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../model/beneficiary_list_view_model.dart';

part 'beneficiary_list_event.dart';
part 'beneficiary_list_state.dart';

class BeneficiaryListBloc extends Bloc<BeneficiaryListEvent, BeneficiaryListState> {
  final ReceiverRepository receiverRepository;
  final UserUtilitiesRepository userUtilitiesRepository;
  List<DetailedReceiver> receiverList = [];

  BeneficiaryListBloc({required this.receiverRepository, required this.userUtilitiesRepository})
      : super(BeneficiaryListState()) {
    on<GetBeneficiaryList>((event, emit) async {
      emit(state.copyWith(status: InProgress()));
      await receiverRepository.getReceiverList().then((value) => emit(state.copyWith(status: InitialStatus())));
    });
    on<BeneficiaryListSubscriptionRequested>(_onBeneficiaryListSubscriptionRequested);
    on<SearchTextChanged>(_onSearchFilter);
  }

  _onSearchFilter(
    SearchTextChanged event,
    Emitter<BeneficiaryListState> emit,
  ) {
    List<BeneficiaryListViewModel>? filteredReceiverList = [];
    if (event.searchString == "") {
      filteredReceiverList = state.defaultReceiverList;
    } else {
      filteredReceiverList = (state.defaultReceiverList != null)
          ? state.defaultReceiverList
              ?.where(
                (receiver) => (receiver.beneficiaryName != null)
                    ? receiver.beneficiaryName!.toLowerCase().contains(event.searchString!.toLowerCase())
                    : false,
              )
              .toList()
          : [];
    }
    emit(state.copyWith(receiverList: filteredReceiverList));
  }

  Future<void> _onBeneficiaryListSubscriptionRequested(
    BeneficiaryListEvent event,
    Emitter<BeneficiaryListState> emit,
  ) async {
    await emit.forEach<List<DetailedReceiver>?>(
      receiverRepository.receiverList(),
      onData: (receiverList) {
        if (receiverList != null) {
          List<BeneficiaryListViewModel> list = [];
          final groupedList = groupBy(receiverList, (receiver) => receiver.defaultPayoutInfo?.mode?.id);
          final _ = groupedList.forEach((key, value) {
            list.add(BeneficiaryListViewModel(title: key ?? "", itemType: PaymentMenuItemType.heading));
            list.addAll(
              value.map(
                (item) => BeneficiaryListViewModel.fromReceiver(
                  data: item,
                  itemType: PaymentMenuItemType.list,
                  title: item.personalInfo?.fullName ?? "",
                ),
              ),
            );
          });
          return state.copyWith(defaultReceiverList: list, receiverList: list);
        } else {
          return state;
        }
      },
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure));
      },
    );
  }
}
