import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'purpose_of_transfer_event.dart';
part 'purpose_of_transfer_state.dart';

class PurposeOfTransferBloc extends Bloc<PurposeOfTransferEvent, PurposeOfTransferState> {
  final CatalogRepository catalogRepository;
  final ReceiverRepository receiverRepository;
  final TransactionActivityRepository transactionActivityRepository;
  String? beneficiaryID;

  PurposeOfTransferBloc({
    required this.catalogRepository,
    required this.receiverRepository,
    required this.transactionActivityRepository,
  }) : super(PurposeOfTransferState()) {
    on<GetCatalog>((event, emit) async {
      await Future.wait([
        _onGetPurposeOfRemittance(event, emit),
        _onGetSourceOfFunds(event, emit),
        _onGetDepositMethodType(event, emit),
      ]);
    });
    on<SendMoney>(_onSendMoney);
    on<PurposeOfRemittanceSelected>((event, emit) => emit(state.copyWith(purposeOfRemittance: event.purposeOfRemittance)));
    on<DepositMethodTypeSelected>((event, emit) => emit(state.copyWith(depositMethodType: event.depositType)));
    on<SourceOfFundOtherSelected>((event, emit) => emit(state.copyWith(sourceOfFundOther: event.sourceOfFundOther)));
    on<PurposeOfRemittanceOtherSelected>(
        (event, emit) => emit(state.copyWith(purposeOfRemittanceOther: event.purposeOfRemittanceOther)));
    on<SourceOfFundSelected>((event, emit) => emit(state.copyWith(sourceOfFund: event.sourceOfFund)));
  }

  Future<bool> _onGetPurposeOfRemittance(
    GetCatalog event,
    Emitter<PurposeOfTransferState> emit,
  ) async {
    final response = await catalogRepository.fetchRemittancePurpose(CatalogFilter(language: "en"));
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (purposeOfRemittanceList) => state.copyWith(purposeOfRemittanceList: purposeOfRemittanceList),
      ),
    );
    return true;
  }

  Future<bool> _onGetSourceOfFunds(
    GetCatalog event,
    Emitter<PurposeOfTransferState> emit,
  ) async {
    final response = await catalogRepository.fetchIncomeList(CatalogFilter(language: "en"));
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (sourceOfFundList) => state.copyWith(sourceOfFundList: sourceOfFundList),
      ),
    );
    return true;
  }

  Future<bool> _onGetDepositMethodType(
    GetCatalog event,
    Emitter<PurposeOfTransferState> emit,
  ) async {
    final response = await catalogRepository.fetchDepositMethodType(CatalogFilter(language: "en"));
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (depositTypeList) => state.copyWith(depositMethodTypeList: depositTypeList),
      ),
    );
    return true;
  }

  void _onSendMoney(
    SendMoney event,
    Emitter<PurposeOfTransferState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));

    final calculationDetail = event.calculateTransactionResult;
    final sendMoneyInfo = CreateTransactionInfo(
      senderInfo: TransactionSenderInfo(
        country: calculationDetail?.senderResult?.country,
        currency: calculationDetail?.senderResult?.currency,
        depositMode: state.depositMethodType,
      ),
      receiverInfo: TransactionReceiverInfo(
        id: event.detailedReceiver?.id,
        payoutInfo: DetailedReceiverPayoutInfo(
          id: "",
          receivingCountry: calculationDetail?.receiverResult?.payoutInfo?.receivingCountry,
          currency: calculationDetail?.receiverResult?.payoutInfo?.currency,
        ),
      ),
      amount: calculationDetail?.senderResult?.realAmount,
      receivingAmount: calculationDetail?.receiverResult?.realAmount,
      calculationMode: CalculationMode.viaBase,
      promotionalCode: event.promotionCode,
      discountAmount: "",
      exchangeRate: calculationDetail?.currentRate,
      taxAmount: calculationDetail?.taxAmount,
      sourceOfIncome: event.sourceOfFunds,
      purposeOfRemittance: event.purposeOfRemittance,
      sourceOfIncomeOther: event.sourceOfFundsOther,
      purposeOfRemittanceOther: event.purposeOfRemittanceOther,
    );
    final response = await transactionActivityRepository.createTransaction(sendMoneyInfo);
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error)),
      (createTransactionResult) => state.copyWith(
        createTransactionResult: createTransactionResult,
        status: Success(),
      ),
    ));
  }
}
