part of 'date_selection_bloc.dart';

class DateSelectionState extends Equatable {
  final DateTime? pickupDate;
  final String pickupDateView;

  String? get dateValidation => pickupDateView.isValidText ? null : "Please select date for pickup";

  const DateSelectionState({this.pickupDateView = "", this.pickupDate});

  DateSelectionState copyWith({String? pickupDateView, DateTime? pickupDate}) {
    return DateSelectionState(
      pickupDate: pickupDate ?? this.pickupDate,
      pickupDateView: pickupDateView ?? this.pickupDateView,
    );
  }

  @override
  List<Object?> get props => [pickupDate, pickupDateView];
}
