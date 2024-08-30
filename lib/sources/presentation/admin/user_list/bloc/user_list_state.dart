part of 'user_list_bloc.dart';

sealed class UserListState extends Equatable {
  const UserListState();
  
  @override
  List<Object> get props => [];
}

final class UserListInitial extends UserListState {}
