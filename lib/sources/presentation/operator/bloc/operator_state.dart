part of 'operator_bloc.dart';

sealed class OperatorState extends Equatable {
  const OperatorState();
  
  @override
  List<Object> get props => [];
}

final class OperatorInitial extends OperatorState {}
