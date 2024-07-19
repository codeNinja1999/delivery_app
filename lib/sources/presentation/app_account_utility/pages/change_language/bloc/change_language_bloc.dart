import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../model/language_model.dart';

part 'change_language_event.dart';
part 'change_language_state.dart';

class ChangeLanguageBloc extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  ChangeLanguageBloc() : super(ChangeLanguageState()) {
    on<GetLocaleList>(_onGetLocaleList);
    on<SelectedLanguage>(_onSelectedLanguage);
  }

  _onGetLocaleList(GetLocaleList event, Emitter<ChangeLanguageState> emit) async {
    emit(state.copyWith(
      currentLocale: event.locale,
      localeList: event.localeList,
      languageModelList:
          event.localeList.map((language) => LanguageModel.fromLanguageList(language, state.selectedLocale)).toList(),
    ));
  }

  _onSelectedLanguage(SelectedLanguage event, Emitter<ChangeLanguageState> emit) async {
    emit(state.copyWith(selectedLocale: event.locale));
  }
}
