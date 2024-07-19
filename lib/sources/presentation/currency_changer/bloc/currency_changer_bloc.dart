import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'currency_changer_event.dart';
part 'currency_changer_state.dart';

class CurrencyChangerBloc extends Bloc<CurrencyChangerEvent, CurrencyChangerState> {
  CatalogRepository catalogRepository;

  CurrencyChangerBloc({required this.catalogRepository}) : super(CurrencyChangerState()) {
    on<GetReceivingCountry>(_onGetReceivingCountry);
    on<GetSelectedCurrencyCode>(_onGetSelectedCurrencyCode);
  }

  _onGetSelectedCurrencyCode(
    GetSelectedCurrencyCode event,
    Emitter<CurrencyChangerState> emit,
  ) async {
    SharedPreferences? sharedPreferences = await SharedPreferences.getInstance();
    final code = sharedPreferences.getString('CURRENCY_CODE');
    emit(state.copyWith(selectedCurrencyCode: code));
  }

  Future<bool> _onGetReceivingCountry(
    GetReceivingCountry event,
    Emitter<CurrencyChangerState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await catalogRepository.fetchreceivingCountry(CatalogFilter(language: "en"));
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (receivingCountryList) => state.copyWith(
          receivingCountryList: receivingCountryList,
          status: Success(),
        ),
      ),
    );
    return true;
  }
}
