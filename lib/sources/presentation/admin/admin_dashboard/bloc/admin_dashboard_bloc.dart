import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/repository/domain/domain.dart';

import '../../../../../repository/domain/user/entities/analytic_data_info.dart';
import '../../../../../repository/domain/user/entities/operator/operator_entities.dart';

part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';

class AdminDashboardBloc extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  final CatalogRepository catalogRepository;
  AdminDashboardBloc({
    required this.userUtilitiesRepository,
    required this.catalogRepository,
  }) : super(AdminDashboardState()) {
    on<GetDashboardData>(
      (event, emit) async {
        emit(state.copyWith(status: InProgress()));
        final result = await Future.wait([
          _onGetAdminInfo(event, emit),
          _onUserList(event, emit),
          _onOperatorList(event, emit),
          _onGetLocation(event, emit),
          _onGetSales(event, emit),
          _onGetServices(event, emit),
        ]);
        if (result.every((e) => e == true)) {
          emit(state.copyWith(status: Success()));
        } else {
          emit(state.copyWith(status: InitialStatus()));
        }
      },
    );

    on<UserInfoSubscriptionRequested>(_onUserInfoSubscriptionRequested);
  }

  Future<void> _onUserInfoSubscriptionRequested(
    UserInfoSubscriptionRequested event,
    Emitter<AdminDashboardState> emit,
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

  Future<bool> _onGetAdminInfo(GetDashboardData event, Emitter<AdminDashboardState> emit) async {
    await userUtilitiesRepository.getUserInfo();
    return true;
  }

  Future<bool> _onUserList(GetDashboardData event, Emitter<AdminDashboardState> emit) async {
    final response = await userUtilitiesRepository.getUserList(PaginationFilter(
      page: 1,
      pageSize: 0,
    ));
    return response.fold((error) {
      emit(state.copyWith(status: SubmissionFailure(error)));
      return false;
    }, (userList) {
      emit(state.copyWith(userList: userList));
      return true;
    });
  }

  Future<bool> _onOperatorList(GetDashboardData event, Emitter<AdminDashboardState> emit) async {
    final response = await userUtilitiesRepository.getOperatorList(PaginationFilter(
      page: 1,
      pageSize: 3,
    ));
    return response.fold((error) {
      emit(state.copyWith(status: SubmissionFailure(error)));
      return false;
    }, (operatorList) {
      emit(state.copyWith(operatorList: operatorList));
      return true;
    });
  }

  Future<bool> _onGetLocation(GetDashboardData event, Emitter<AdminDashboardState> emit) async {
    final response = await catalogRepository.fetchLocation();
    return response.fold((error) {
      emit(state.copyWith(status: SubmissionFailure(error)));
      return false;
    }, (locationList) {
      emit(state.copyWith(locationList: locationList));
      return true;
    });
  }

  Future<bool> _onGetServices(GetDashboardData event, Emitter<AdminDashboardState> emit) async {
    final response = await catalogRepository.fetchServiceType();
    return response.fold((error) {
      emit(state.copyWith(status: SubmissionFailure(error)));
      return false;
    }, (serviceTypeList) {
      emit(state.copyWith(serviceTypeList: serviceTypeList));
      return true;
    });
  }

  Future<bool> _onGetSales(GetDashboardData event, Emitter<AdminDashboardState> emit) async {
    final response = await userUtilitiesRepository.fetchAnalyticData(DateFilter(from: 1, to: 10));
    return response.fold((error) {
      emit(state.copyWith(status: SubmissionFailure(error)));
      return false;
    }, (analyticData) {
      emit(state.copyWith(analyticsInfo: analyticData));
      return true;
    });
  }
}
