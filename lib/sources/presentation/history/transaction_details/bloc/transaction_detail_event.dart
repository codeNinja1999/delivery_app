part of 'transaction_detail_bloc.dart';

abstract class TransactionDetailEvent {}

class FetchTransactionDetail extends TransactionDetailEvent {}

class DownloadImage extends TransactionDetailEvent {}

class Cancel extends TransactionDetailEvent {}

class GetInfo extends TransactionDetailEvent {}

class UserInfoSubscriptionRequestedDetail extends TransactionDetailEvent {}
