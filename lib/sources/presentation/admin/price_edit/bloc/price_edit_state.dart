part of 'price_edit_bloc.dart';

sealed class PriceEditState extends Equatable {
  const PriceEditState();
  
  @override
  List<Object> get props => [];
}

final class PriceEditInitial extends PriceEditState {}
