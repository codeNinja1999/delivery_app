part of 'operator_details_bloc.dart';

sealed class OperatorDetailsState extends Equatable {
  const OperatorDetailsState();
  
  @override
  List<Object> get props => [];
}

final class OperatorDetailsInitial extends OperatorDetailsState {}
