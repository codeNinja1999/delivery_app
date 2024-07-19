part of 'promotion_bloc.dart';

class PromotionState extends Equatable {
  final String? changeLanguage;
  final int pageIndex;
  final FormStatus status;

  PromotionState({
    this.changeLanguage,
    this.pageIndex = 0,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  PromotionState copyWith({
    String? changeLanguage,
    int? pageIndex,
    FormStatus? status,
  }) {
    return PromotionState(
      pageIndex: pageIndex ?? this.pageIndex,
      changeLanguage: changeLanguage ?? this.changeLanguage,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [status, pageIndex, changeLanguage];

  final List<SliderModel> sliderItems = [
    SliderModel(
      imageString: AppImages.onboard1,
      title: LocaleKeys.onboardTitle1.tr(args: [LocaleKeys.appName.value]),
      description: LocaleKeys.onboardDescription1.value,
    ),
    SliderModel(
      imageString: AppImages.onboard2,
      title: LocaleKeys.onboardTitle2.value,
      description: LocaleKeys.onboardDescription2.value,
    ),
    SliderModel(
      imageString: AppImages.onboard3,
      title: LocaleKeys.onboardTitle3.value,
      description: LocaleKeys.onboardDescription3.value,
    ),
    SliderModel(
      imageString: AppImages.onboard4,
      title: LocaleKeys.onboardTitle1.tr(args: [LocaleKeys.appName.value]),
      description: LocaleKeys.onboardDescription1.value,
    ),
  ];
}
