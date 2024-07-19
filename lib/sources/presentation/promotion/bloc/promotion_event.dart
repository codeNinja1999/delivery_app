part of 'promotion_bloc.dart';

abstract class PromotionEvent {}

class SetAppLaunchStatus extends PromotionEvent {}

class SaveChangeLanguage extends PromotionEvent {
  final String? selectedLanguage;
  SaveChangeLanguage(this.selectedLanguage);
}

class ChangePageIndex extends PromotionEvent {
  final int? pageIndex;
  ChangePageIndex(this.pageIndex);
}
