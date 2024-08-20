part of 'update_operator_bloc.dart';

sealed class UpdateOperatorState extends Equatable {
  const UpdateOperatorState();
  
  @override
  List<Object> get props => [];
}

final class UpdateOperatorInitial extends UpdateOperatorState {}
