import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListInitial()) {
    on<UserListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
