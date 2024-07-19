import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/resources/resources.dart';
import '../model/slider_model.dart';

part 'promotion_event.dart';
part 'promotion_state.dart';

class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  final AppAuthenticationRepository appAuthenticationRepository;

  PromotionBloc({required this.appAuthenticationRepository}) : super(PromotionState()) {
    on<SaveChangeLanguage>((event, emit) {
      emit(state.copyWith(changeLanguage: event.selectedLanguage));
    });

    on<ChangePageIndex>((event, emit) {
      emit(state.copyWith(pageIndex: event.pageIndex));
    });

    on<SetAppLaunchStatus>((event, emit) async {
      await appAuthenticationRepository.setAppLaunchStatus();
    });
  }
}
