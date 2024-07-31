part of 'date_selection_bloc.dart';

abstract class DateSelectionEvent {}

class DateSelected extends DateSelectionEvent {
  final String pickupDate;
  DateSelected(this.pickupDate);
}
