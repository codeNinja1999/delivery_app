import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/data/data.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/catalog.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<SaveLocation>((event, emit) {
      emit(state.copyWith(location: event.location));
    });
    on<SaveServiceType>((event, emit) {
      emit(state.copyWith(service: event.serviceType, totalWeight: event.totalWeight));
    });
    on<SavePickupDate>((event, emit) {
      emit(state.copyWith(pickupDate: event.pickupDate));
    });
    on<SaveHygieneParameter>((event, emit) {
      emit(state.copyWith(
        noBlood: event.noBlood,
        noPetHair: event.noPetHair,
        noBiohazard: event.noBiohazard,
      ));
    });
  }
}
