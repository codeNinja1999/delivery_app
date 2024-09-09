import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/catalog.dart';
import 'package:fresh_fold_delivery/repository/domain/hygiene_info/hygiene_info.dart';
import 'package:fresh_fold_delivery/repository/domain/pickup_order/pickup_order.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<SaveLocation>((event, emit) {
      emit(state.copyWith(location: event.location));
    });
    on<SaveServiceType>((event, emit) {
      emit(state.copyWith(service: event.serviceType, totalWeight: event.totalWeight, totalAmount: event.totalAmount));
    });
    on<SavePickupDate>((event, emit) {
      emit(state.copyWith(pickupDate: event.pickupDate));
    });
    on<SaveHygieneParameter>((event, emit) {
      emit(state.copyWith(hygieneInfo: event.hygieneInfo));
    });
  }
}
