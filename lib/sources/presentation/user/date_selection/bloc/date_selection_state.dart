part of 'date_selection_bloc.dart';

class DateSelectionState extends Equatable {
  final String pickupDate;

  String? get dateValidation => pickupDate.isValidText ? null : "Please select date for pickup";

  const DateSelectionState({this.pickupDate = ""});

  DateSelectionState copyWith({String? pickupDate}) {
    return DateSelectionState(pickupDate: pickupDate ?? this.pickupDate);
  }

  @override
  List<Object> get props => [pickupDate];
}
