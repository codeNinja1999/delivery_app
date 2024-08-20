part of 'operator_list_bloc.dart';

sealed class OperatorListState extends Equatable {
  const OperatorListState();
  
  @override
  List<Object> get props => [];
}

final class OperatorListInitial extends OperatorListState {}
