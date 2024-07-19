import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'receiving_country_event.dart';
part 'receiving_country_state.dart';

class PaymentModeSelectedSuccess extends FormStatus {}

class ReceivingCountryBloc extends Bloc<ReceivingCountryEvent, ReceivingCountryState> {
  CatalogRepository catalogRepository;
  ReceivingCountryBloc({required this.catalogRepository}) : super(ReceivingCountryState()) {
    on<GetReceivingCountry>(_onGetReceivingCountry);
    on<ValidateReceivingCountry>((event, emit) => emit(state.copyWith(status: Success())));
    on<ReceivingCountrySelected>(_onReceivingCountrySelected);
    on<GetPayoutType>(_onGetPayoutType);
    on<PayoutTypeSelected>(_onPayoutTypeSelected);
    on<TogglePaymentMethodDialog>(
      (event, emit) => emit(state.copyWith(showPaymentMethodDialog: !state.showPaymentMethodDialog)),
    );
  }

  Future<bool> _onGetReceivingCountry(
    GetReceivingCountry event,
    Emitter<ReceivingCountryState> emit,
  ) async {
    final response = await catalogRepository.fetchreceivingCountry(CatalogFilter(language: "en"));
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (receivingCountryList) => state.copyWith(receivingCountryList: receivingCountryList),
      ),
    );
    return true;
  }

  _onReceivingCountrySelected(
    ReceivingCountrySelected event,
    Emitter<ReceivingCountryState> emit,
  ) {
    final flagUrl = "${AppConstants.countryImageUrl}${event.receivingCountry.countryCode?.toLowerCase() ?? ""}.svg";
    emit(state.copyWith(receivingCountry: event.receivingCountry, flag: flagUrl));
    add(GetPayoutType(event.receivingCountry.id));
  }

  void _onGetPayoutType(
    GetPayoutType event,
    Emitter<ReceivingCountryState> emit,
  ) async {
    final filter = CatalogFilter(
      language: 'en',
      receivingCountry: event.receivingCountry,
      countryCode: event.receivingCountry,
    );
    final response = await catalogRepository.fetchpaymentMode(filter);
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (payoutTypeList) => state.copyWith(payoutTypeList: payoutTypeList),
      ),
    );
  }

  void _onPayoutTypeSelected(
    PayoutTypeSelected event,
    Emitter<ReceivingCountryState> emit,
  ) {
    final paymentType = PaymentType.fromPaymentTypeCode(event.payoutType.paymentType ?? "");
    emit(state.copyWith(payoutType: event.payoutType, paymentType: paymentType, status: PaymentModeSelectedSuccess()));
  }
}
