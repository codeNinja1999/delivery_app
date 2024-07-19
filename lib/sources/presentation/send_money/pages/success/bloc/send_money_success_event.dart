part of 'send_money_success_bloc.dart';

abstract class SendMoneySuccessEvent {}

class DownloadQRButtonClicked extends SendMoneySuccessEvent {
  final GlobalKey key;

  DownloadQRButtonClicked(this.key);
}

class CopyTextChanged extends SendMoneySuccessEvent {}
