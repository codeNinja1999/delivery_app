part of 'send_money_bloc.dart';

class SendMoneyState extends Equatable {
  final bool showAmount;
  final bool isSelected;
  final bool isReceiverResettable;
  final String? promotionCode;
  final DetailedReceiver? detailedReceiver;
  final CalculateTransactionResult? calculateTransactionResult;
  final CreateTransactionInfo? createTransactionInfo;
  final CreateTransactionResult? createdTransactionResult;
  final ConfirmTransactionResult? confirmTransactionResult;
  final FormStatus? status;

  SendMoneyState({
    this.showAmount = false,
    this.isSelected = false,
    this.isReceiverResettable = false,
    this.detailedReceiver,
    this.promotionCode,
    this.calculateTransactionResult,
    this.createTransactionInfo,
    this.createdTransactionResult,
    this.confirmTransactionResult,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  SendMoneyState copyWith({
    bool? showAmount,
    bool? isSelected,
    String? promotionCode,
    PaymentMode? paymentMode,
    bool? isReceiverResettable,
    DetailedReceiver? detailedReceiver,
    CalculateTransactionResult? calculateTransactionResult,
    CreateTransactionInfo? createTransactionInfo,
    CreateTransactionResult? createdTransactionResult,
    ConfirmTransactionResult? confirmTransactionResult,
    FormStatus? status,
  }) {
    final state = SendMoneyState(
      showAmount: showAmount ?? this.showAmount,
      isSelected: isSelected ?? this.isSelected,
      promotionCode: promotionCode ?? this.promotionCode,
      isReceiverResettable: isReceiverResettable ?? this.isReceiverResettable,
      detailedReceiver: detailedReceiver ?? this.detailedReceiver,
      calculateTransactionResult: calculateTransactionResult ?? this.calculateTransactionResult,
      createTransactionInfo: createTransactionInfo ?? this.createTransactionInfo,
      createdTransactionResult: createdTransactionResult ?? this.createdTransactionResult,
      confirmTransactionResult: confirmTransactionResult ?? this.confirmTransactionResult,
      status: status ?? InitialStatus(),
    );
    return state;
  }

  @override
  List<Object?> get props => [
        isSelected,
        showAmount,
        promotionCode,
        detailedReceiver,
        isReceiverResettable,
        calculateTransactionResult,
        createTransactionInfo,
        createdTransactionResult,
        confirmTransactionResult,
        status,
      ];
}
