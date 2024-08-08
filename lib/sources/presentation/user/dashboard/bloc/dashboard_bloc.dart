import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  final CatalogRepository catalogRepository;

  DashboardBloc({
    required this.userUtilitiesRepository,
    required this.catalogRepository,
  }) : super(DashboardState()) {
    on<GetDashboardData>((event, emit) async {
      await Future.wait([
        _onGetUserInfo(event, emit),
      ]);
    });
  }

  Future<bool> _onGetUserInfo(DashboardEvent event, Emitter<DashboardState> emit) async {
    return true;
  }
}
