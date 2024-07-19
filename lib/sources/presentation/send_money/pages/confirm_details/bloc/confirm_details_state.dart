part of 'confirm_details_bloc.dart';

class ConfirmDetailsState extends Equatable {
  final CreateTransactionResult? createTransactionResult;
  final ConfirmTransactionResult? confirmTransactionResult;
  final ConfirmDetailsModelView? confirmDetailsModelView;
  final FormStatus status;

  ConfirmDetailsState({
    this.createTransactionResult,
    this.confirmTransactionResult,
    this.confirmDetailsModelView,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  ConfirmDetailsState copyWith({
    CreateTransactionResult? createTransactionResult,
    ConfirmTransactionResult? confirmTransactionResult,
    ConfirmDetailsModelView? confirmDetailsModelView,
    FormStatus? status,
  }) {
    return ConfirmDetailsState(
      createTransactionResult: createTransactionResult ?? this.createTransactionResult,
      confirmTransactionResult: confirmTransactionResult ?? this.confirmTransactionResult,
      confirmDetailsModelView: confirmDetailsModelView ?? this.confirmDetailsModelView,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [createTransactionResult, confirmTransactionResult, confirmDetailsModelView, status];
}
