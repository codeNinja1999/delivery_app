import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../../order_history/model/transaction_list_view_model.dart';
import '../model/exchange_rate_history_view_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final TransactionActivityRepository transactionActivityRepository;
  final UserUtilitiesRepository userUtilitiesRepository;
  final ExchangeRateRepository exchangeRepository;
  final CatalogRepository catalogRepository;

  DashboardBloc({
    required this.userUtilitiesRepository,
    required this.transactionActivityRepository,
    required this.catalogRepository,
    required this.exchangeRepository,
  }) : super(DashboardState()) {
    on<UserInfoSubscriptionRequested>(_onUserInfoSubscriptionRequested);
    on<ShowAmountChanged>((event, emit) {
      emit(state.copyWith(showAmount: event.showAmount));
    });
    on<GetExchangeRateHistoryList>(_onGetExchangeRateHistoryList);
    on<TransactionListSubscriptionRequested>(_transactionListSubscriptionRequested);
    on<GetDashboardData>((event, emit) async {
      emit(state.copyWith(status: InProgress()));
      final result = await Future.wait([
        _onGetUserInfo(event, emit),
        _onGetReceivingCountry(event, emit),
        _onGetTransactionList(event, emit),
      ]);
      if (result.every((element) => element == true)) {
        if (state.countryCodeForHistoryRate == null) {
          if (state.receivingCountryList.isNotEmpty) {
            // final isUserNationalityInList = state.receivingCountryList
            //     .any((element) => element.countryCode == state.userInfo?.personalInfo.nationality?.id);

            // if (isUserNationalityInList) {
            //   add(GetExchangeRateHistoryList(state.userInfo?.personalInfo.nationality?.id));
            // } else {
            //   add(GetExchangeRateHistoryList(state.receivingCountryList.first.id));
            // }
          }
        }
      }
      emit(state.copyWith(status: InitialStatus()));
    });
  }

  Future<bool> _onGetReceivingCountry(
    GetDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    if (state.countryCodeForHistoryRate != null) {
      return true;
    } else {
      final response = await catalogRepository.fetchreceivingCountry(CatalogFilter(language: "en"));
      response.fold((error) => emit(state.copyWith(status: SubmissionFailure(error))), (receivingCountryList) {
        if (receivingCountryList.isNotEmpty) {
          emit(state.copyWith(receivingCountryList: receivingCountryList));
        }
      });
      return true;
    }
  }

  Future<void> _onUserInfoSubscriptionRequested(
    UserInfoSubscriptionRequested event,
    Emitter<DashboardState> emit,
  ) async {
    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (userInfo) => userInfo != null ? state.copyWith(userInfo: userInfo) : state,
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure));
      },
    );
  }

  Future<bool> _onGetUserInfo(DashboardEvent event, Emitter<DashboardState> emit) async {
    // final _ = await userUtilitiesRepository.getUserInfo();
    return true;
  }

  Future<bool> _onGetTransactionList(
    GetDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    final filter = TransactionListFilter(
      pageNumber: "1",
      itemCount: "20",
      startDate: "",
      endDate: "",
      issueType: "02",
    );
    await transactionActivityRepository.getTransactionList(filter);
    return true;
  }

  Future<void> _transactionListSubscriptionRequested(
    TransactionListSubscriptionRequested event,
    Emitter<DashboardState> emit,
  ) async {
    await emit.forEach<List<DetailedTransaction>?>(transactionActivityRepository.transactionList(),
        onData: (transactionList) {
      if (transactionList != null) {
        var transactionFilter =
            transactionList.where((transaction) => transaction.status?.type == TransactionType.pendingPayment).toList();
        return state.copyWith(
            pendingList: transactionFilter.map((item) => TransactionListViewModel.fromTransaction(item)).toList());
      } else {
        return state;
      }
    }, onError: (error, __) {
      return state;
    });
  }

  void _onGetExchangeRateHistoryList(
    GetExchangeRateHistoryList event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(countryCodeForHistoryRate: event.countryCodeForHistoryRate));
    final rateFilter = ExchangeRateHistoryListRequestModel(country: event.countryCodeForHistoryRate);
    final response = await exchangeRepository.getExchangeRateHistoryList(rateFilter);
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (rateHistoryResult) {
        emit(state.copyWith(
          exchangeRateHistoryViewModel:
              ExchangeRateHistoryViewModel.fromHistory(rateHistoryResult, state.receivingCountryList.first),
        ));
      },
    );
  }
}
