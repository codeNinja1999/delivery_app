part of 'send_money_success_bloc.dart';

class SendMoneySuccessState extends Equatable {
  const SendMoneySuccessState({this.copyText = false});

  final bool copyText;

  SendMoneySuccessState copyWith({bool? copyText}) {
    return SendMoneySuccessState(copyText: copyText ?? this.copyText);
  }

  @override
  List<Object> get props => [copyText];
}

class SendMoneySuccessInitial extends SendMoneySuccessState {}

class DownloadInProgress extends SendMoneySuccessState {}

class DownloadSuccess extends SendMoneySuccessState {}

class ErrorOnDownloading extends SendMoneySuccessState {
  final String errorMessage;
  const ErrorOnDownloading(this.errorMessage);
}
