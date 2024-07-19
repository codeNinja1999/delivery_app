part of 'change_language_bloc.dart';

abstract class ChangeLanguageEvent {}

class GetLanguageList extends ChangeLanguageEvent {}

class GetLocaleList extends ChangeLanguageEvent {
  final List<Locale> localeList;
  final Locale locale;
  GetLocaleList(this.localeList, this.locale);
}

class SelectedLanguage extends ChangeLanguageEvent {
  final Locale locale;
  SelectedLanguage(this.locale);
}
