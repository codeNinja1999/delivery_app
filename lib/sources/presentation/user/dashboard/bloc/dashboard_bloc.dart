import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../../order_history/model/transaction_list_view_model.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final TransactionActivityRepository transactionActivityRepository;
  final UserUtilitiesRepository userUtilitiesRepository;
  final CatalogRepository catalogRepository;

  DashboardBloc({
    required this.userUtilitiesRepository,
    required this.transactionActivityRepository,
    required this.catalogRepository,
  }) : super(DashboardState()) {
    on<UserInfoSubscriptionRequested>(_onUserInfoSubscriptionRequested);
    on<ShowAmountChanged>((event, emit) {
      emit(state.copyWith(showAmount: event.showAmount));
    });
    on<GetDashboardData>((event, emit) async {
      emit(state.copyWith(status: InProgress()));
      final result = await Future.wait([
        _onGetUserInfo(event, emit),
        _onGetReceivingCountry(event, emit),
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
}
