import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../model/exchange_rate_view_model.dart';

part 'exchange_rate_event.dart';
part 'exchange_rate_state.dart';

class CalculateExchangeRateSuccess extends FormStatus {}

class ExchangeRateBloc extends Bloc<ExchangeRateEvent, ExchangeRateState> {
  final CatalogRepository catalogRepository;
  final UserUtilitiesRepository userUtilitiesRepository;
  final TransactionActivityRepository transactionActivityRepository;

  ExchangeRateBloc({
    required this.transactionActivityRepository,
    required this.catalogRepository,
    required this.userUtilitiesRepository,
  }) : super(ExchangeRateState()) {
    on<GetTransactionListInfo>(_onGetTransactionList);
    on<UserInfoSubscription>(_onUserInfoSubscriptionRequested);
    on<GetReceivingCountry>(_onGetReceivingCountry);
    on<GetPayoutType>(_onGetPayoutType);
    on<CalculateTransaction>(_onCalculateTransaction);
    on<ReceivingCountrySelected>(_onReceivingCountrySelected);
    on<TransactionListSubscriptionRequested>(_transactionListSubscriptionRequested);
    on<PaymentModeSelected>((event, emit) {
      emit(state.copyWith(paymentMode: event.paymentMode));
      (state.amount != "") ? add(CalculateTransaction(calculationMode: state.mode, amount: state.amount)) : null;
    });
    on<ShowDiscountPromoChanged>((event, emit) => emit(state.copyWith(showDiscountPromo: event.showDiscountPromo)));
    on<ReceiverSelectedChanged>((event, emit) => emit(state.copyWith(isBeneficiarySelected: event.isBeneficiarySelected)));
    on<PromoCodeChanged>((event, emit) => emit(state.copyWith(promotionCode: event.promotionCode)));
    on<CheckKycStatus>((event, emit) {
      {
        if (state.calculateTransactionResult != null) {
          emit(state.copyWith(status: Success()));
        } else {
          emit(state.copyWith(status: SubmissionFailure(Exception(LocaleKeys.amountErrorMsg.value))));
        }
      }
    });
  }

  Future<void> _onGetTransactionList(
    GetTransactionListInfo event,
    Emitter<ExchangeRateState> emit,
  ) async {
    final filter = TransactionListFilter(
      pageNumber: "",
      itemCount: "",
      startDate: "",
      endDate: "",
      issueType: "02",
    );
    await transactionActivityRepository.getTransactionList(filter);
  }

  Future<void> _transactionListSubscriptionRequested(
    TransactionListSubscriptionRequested event,
    Emitter<ExchangeRateState> emit,
  ) async {
    await emit.forEach<List<DetailedTransaction>?>(transactionActivityRepository.transactionList(),
        onData: (transactionList) {
      if (transactionList != null) {
        var transactionFilter =
            transactionList.where((element) => element.status?.type == TransactionType.pendingPayment).toList();
        return state.copyWith(isPendingTransaction: transactionFilter.isEmpty ? false : true);
      } else {
        return state;
      }
    }, onError: (error, __) {
      final failure = error as Exception;
      return state.copyWith(status: SubmissionFailure(failure));
    });
  }

  Future<bool> _onGetReceivingCountry(
    GetReceivingCountry event,
    Emitter<ExchangeRateState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await catalogRepository.fetchreceivingCountry(CatalogFilter(language: "en"));
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (receivingCountryList) => state.copyWith(
          receivingCountryList: receivingCountryList,
          status: InitialStatus(),
        ),
      ),
    );
    return true;
  }

  _onReceivingCountrySelected(
    ReceivingCountrySelected event,
    Emitter<ExchangeRateState> emit,
  ) async {
    final flagUrl = "${AppConstants.countryImageUrl}${event.receivingCountry?.id.toLowerCase() ?? ""}.svg";
    (state.isBeneficiarySelected ?? false) ? null : add(GetPayoutType(event.receivingCountry?.id ?? ""));
    emit(state.copyWith(receivingCountry: event.receivingCountry, flag: flagUrl));
  }

  _onGetPayoutType(
    GetPayoutType event,
    Emitter<ExchangeRateState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));

    final filter = CatalogFilter(
      language: 'en',
      receivingCountry: event.receivingCountry,
      countryCode: event.receivingCountry,
    );
    final response = await catalogRepository.fetchpaymentMode(filter);
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (paymentModeList) {
        final containId = paymentModeList.map((paymentMode) => paymentMode.id).contains(state.paymentMode?.id);
        final selectedItem = paymentModeList.where((element) => element.id == state.paymentMode?.id).toList();
        emit(state.copyWith(
          paymentModeList: paymentModeList,
          isReset: true,
          status: InitialStatus(),
        ));
        if (containId && selectedItem.isNotEmpty) {
          add(PaymentModeSelected(selectedItem.first));
        }
      },
    );
  }

  void _onCalculateTransaction(
    CalculateTransaction event,
    Emitter<ExchangeRateState> emit,
  ) async {
    emit(state.copyWith(amount: event.amount, mode: event.calculationMode));
    if (state.paymentMode != null) {
      emit(state.copyWith(status: InProgress()));
      final info = CalculateTransactionInfo(
        senderInfo: TransactionSenderInfo(
          country: const Country(id: AppConstants.senderCountryCode, value: AppConstants.senderCountry),
          currency: const Catalog(id: AppConstants.senderCurrencyCode, value: AppConstants.senderCurrencyCode),
        ),
        receiverInfo: TransactionReceiverInfo(
          id: event.receiver?.id ?? "",
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
          (data) => state.copyWith(
            calculateTransactionResult: data,
            mode: event.calculationMode,
            status: CalculateExchangeRateSuccess(),
            exchangeRateViewModel: ExchangeRateViewModel.fromRateInfo(data),
          ),
        ),
      );
    } else {
      emit(state.copyWith(status: SubmissionFailure(Exception("Receiving method is not selected"))));
    }
  }

  Future<void> _onUserInfoSubscriptionRequested(
    UserInfoSubscription event,
    Emitter<ExchangeRateState> emit,
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
}
