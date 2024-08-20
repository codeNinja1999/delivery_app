part of 'add_user_location_bloc.dart';

sealed class AddUserLocationState extends Equatable {
  const AddUserLocationState();
  
  @override
  List<Object> get props => [];
}

final class AddUserLocationInitial extends AddUserLocationState {}
