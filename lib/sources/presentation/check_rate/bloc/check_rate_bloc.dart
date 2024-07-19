import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/presentation/widgets/widgets.dart';

part 'check_rate_event.dart';
part 'check_rate_state.dart';

class CheckRateBloc extends Bloc<CheckRateEvent, CheckRateState> {
  final CatalogRepository catalogRepository;
  final TransactionActivityRepository transactionActivityRepository;
  CheckRateBloc({required this.catalogRepository, required this.transactionActivityRepository}) : super(CheckRateState()) {
    on<GetCountry>(_onGetReceivingCountry);
    on<GetPayoutType>(_onGetPayoutType);
    on<CalculateTransaction>(_onCalculateTransaction);
    on<ReceivingCountrySelected>(_onReceivingCountrySelected);
    on<PaymentModeSelected>((event, emit) {
      emit(state.copyWith(paymentMode: event.paymentMode));
      (state.amount != "") ? add(CalculateTransaction(calculationMode: state.mode, amount: state.amount)) : null;
    });
    on<ReceiverSelectedChanged>((event, emit) => emit(state.copyWith(isBeneficiarySelected: event.isBeneficiarySelected)));
  }

  _onGetReceivingCountry(
    GetCountry event,
    Emitter<CheckRateState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));

    final response = await catalogRepository.fetchreceivingCountry(CatalogFilter(language: "en"));

    response.fold((error) => emit(state.copyWith(status: SubmissionFailure(error))), (receivingCountryList) {
      if (receivingCountryList.isNotEmpty) {
        add(GetPayoutType(receivingCountryList.first.id));
        emit(state.copyWith(
          status: Success(),
          receivingCountryList: receivingCountryList
              .map((e) => ReceivingCountry(id: e.id, value: e.value, currencyCode: e.currencyCode))
              .toList(),
          receivingCountry: receivingCountryList.first,
          dropdownList: receivingCountryList.map(
            (item) {
              return DropdownMenuItem<ReceivingCountry>(
                value: ReceivingCountry(
                  id: item.id,
                  value: item.value,
                  currencyCode: item.currencyCode,
                ),
                child: Row(
                  children: [
                    BorderImage(
                      imageUrl: "${AppConstants.countryImageUrl}${item.id.toLowerCase()}.svg",
                      size: AppSize.viewSpacing,
                    ),
                    const SizedBox(width: AppSize.cornerRadiusMedium),
                    Text(item.currencyCode ?? "")
                  ],
                ),
              );
            },
          ).toList(),
        ));
      } else {
        emit(state.copyWith());
      }
    });
  }

  _onReceivingCountrySelected(
    ReceivingCountrySelected event,
    Emitter<CheckRateState> emit,
  ) async {
    add(GetPayoutType(event.receivingCountry?.id ?? ""));
    final flagUrl = "${AppConstants.countryImageUrl}${event.receivingCountry?.id.toLowerCase() ?? ""}.svg";
    emit(state.copyWith(receivingCountry: event.receivingCountry, flag: flagUrl, status: Success()));
  }

  _onGetPayoutType(
    GetPayoutType event,
    Emitter<CheckRateState> emit,
  ) async {
    final filter = CatalogFilter(
      language: 'en',
      receivingCountry: event.receivingCountry,
      countryCode: event.receivingCountry,
    );
    final response = await catalogRepository.fetchpaymentMode(filter);
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (paymentModeList) {
        emit(state.copyWith(paymentModeList: paymentModeList));
        final containId = paymentModeList.map((paymentMode) => paymentMode.id).contains(state.paymentMode?.id);
        final selectedItem = paymentModeList.where((element) => element.id == state.paymentMode?.id).toList();
        emit(state.copyWith(paymentModeList: paymentModeList, isReset: true));
        if (containId && selectedItem.isNotEmpty) {
          add(PaymentModeSelected(selectedItem.first));
        } else {
          (paymentModeList.isNotEmpty) ? add(PaymentModeSelected(paymentModeList.first)) : null;
        }
      },
    );
  }

  void _onCalculateTransaction(
    CalculateTransaction event,
    Emitter<CheckRateState> emit,
  ) async {
    emit(state.copyWith(status: InProgress(), mode: event.calculationMode, amount: event.amount));

    final info = CalculateTransactionInfo(
      senderInfo: TransactionSenderInfo(
        country: const Country(id: AppConstants.senderCountryCode, value: AppConstants.senderCountry),
        currency: const Catalog(id: AppConstants.senderCurrencyCode, value: AppConstants.senderCurrencyCode),
      ),
      receiverInfo: TransactionReceiverInfo(
        id: "",
        payoutInfo: DetailedReceiverPayoutInfo(
          receivingCountry: state.receivingCountry,
          currency:
              Catalog(id: state.receivingCountry?.currencyCode ?? "", value: state.receivingCountry?.currencyCode ?? ""),
          mode: state.paymentMode,
        ),
      ),
      calculationMode: event.calculationMode,
      amount: event.amount,
      promotionalCode: state.promotionCode,
      discountAmount: "",
    );

    final response = await transactionActivityRepository.calculateTransaction(info);

    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (data) => state.copyWith(calculateTransactionResult: data, mode: event.calculationMode),
      ),
    );
  }
}
