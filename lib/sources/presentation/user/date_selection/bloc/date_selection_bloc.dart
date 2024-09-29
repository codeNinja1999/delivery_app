import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'date_selection_event.dart';
part 'date_selection_state.dart';

class DateSelectionBloc extends Bloc<DateSelectionEvent, DateSelectionState> {
  DateSelectionBloc() : super(DateSelectionState()) {
    on<DateSelected>((event, emit) {
      emit(state.copyWith(pickupDate: event.pickupDate, pickupDateView: DateFormat('yyyy-MM-dd').format(event.pickupDate)));
    });
    on<ValidateDate>(_onValidateDate);
  }

  _onValidateDate(
    ValidateDate event,
    Emitter<DateSelectionState> emit,
  ) {
    if (state.pickupDate != null) {
      emit(state.copyWith(status: Success()));
    } else {
      emit(state.copyWith(status: SubmissionFailure(Exception("Pickup Date is not selected"))));
    }
  }
}
