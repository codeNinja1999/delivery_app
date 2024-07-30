part of 'date_selection_bloc.dart';

sealed class DateSelectionState extends Equatable {
  const DateSelectionState();
  
  @override
  List<Object> get props => [];
}

final class DateSelectionInitial extends DateSelectionState {}
