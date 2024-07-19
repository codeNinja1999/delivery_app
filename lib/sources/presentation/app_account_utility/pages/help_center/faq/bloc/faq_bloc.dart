import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/app_core.dart';
import '../faq.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  FaqBloc() : super(FaqState()) {
    on<FetchJSON>((event, emit) async {
      try {
        // Load JSON data
        String jsonData = await rootBundle.loadString('assets/faq/faq.json');
        Map<String, dynamic> data = json.decode(jsonData);

        // Process your JSON data here
        // print(data);
        emit(state.copyWith(faqModel: FAQModel.fromJson(data)));
      } on Exception catch (e) {
        emit(state.copyWith(status: SubmissionFailure(e)));
      }
    });
  }
}
