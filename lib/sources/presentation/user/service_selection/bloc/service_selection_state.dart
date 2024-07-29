part of 'service_selection_bloc.dart';

sealed class ServiceSelectionState extends Equatable {
  const ServiceSelectionState();
  
  @override
  List<Object> get props => [];
}

final class ServiceSelectionInitial extends ServiceSelectionState {}
