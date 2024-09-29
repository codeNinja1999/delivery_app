part of 'date_selection_bloc.dart';

class DateSelectionState extends Equatable {
  final DateTime? pickupDate;
  final String pickupDateView;
  final FormStatus status;

  String? get dateValidation => pickupDateView.isValidText ? null : "Please select date for pickup";

  DateSelectionState({this.pickupDateView = "", this.pickupDate, status})
      : status = (status != null) ? status : InitialStatus();

  DateSelectionState copyWith({String? pickupDateView, DateTime? pickupDate, FormStatus? status}) {
    return DateSelectionState(
      pickupDate: pickupDate ?? this.pickupDate,
      pickupDateView: pickupDateView ?? this.pickupDateView,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [pickupDate, pickupDateView, status];
}
