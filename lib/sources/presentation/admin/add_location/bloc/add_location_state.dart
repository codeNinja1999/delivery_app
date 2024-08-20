part of 'add_location_bloc.dart';

sealed class AddLocationState extends Equatable {
  const AddLocationState();
  
  @override
  List<Object> get props => [];
}

final class AddLocationInitial extends AddLocationState {}
