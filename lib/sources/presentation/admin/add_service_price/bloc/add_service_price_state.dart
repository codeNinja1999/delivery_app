part of 'add_service_price_bloc.dart';

sealed class AddServicePriceState extends Equatable {
  const AddServicePriceState();
  
  @override
  List<Object> get props => [];
}

final class AddServicePriceInitial extends AddServicePriceState {}
