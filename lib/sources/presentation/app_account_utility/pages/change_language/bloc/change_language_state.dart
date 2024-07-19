part of 'change_language_bloc.dart';

class ChangeLanguageState extends Equatable {
  final List<String>? listOfLanguage;
  final List<Locale>? localeList;
  final Locale? currentLocale;
  final Locale? selectedLocale;
  final List<LanguageModel>? languageModelList;
  final FormStatus status;

  ChangeLanguageState({
    this.listOfLanguage,
    this.localeList,
    this.languageModelList,
    this.currentLocale,
    this.selectedLocale,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  ChangeLanguageState copyWith({
    List<String>? listOfLanguage,
    List<Locale>? localeList,
    Locale? currentLocale,
    Locale? selectedLocale,
    List<LanguageModel>? languageModelList,
    FormStatus? status,
  }) {
    return ChangeLanguageState(
      listOfLanguage: listOfLanguage ?? this.listOfLanguage,
      languageModelList: languageModelList ?? this.languageModelList,
      localeList: localeList ?? this.localeList,
      currentLocale: currentLocale ?? this.currentLocale,
      selectedLocale: selectedLocale ?? this.selectedLocale,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [listOfLanguage, languageModelList, localeList, status];

  final List<LanguageModel> sliderItems = [
    // LanguageModel(
    //   1,
    //   "${AppConstants.countryImageUrl}usa.svg",
    //   LocaleKeys.english.value,
    //   'en',
    //   false,
    // ),
    // LanguageModel(
    //   1,
    //   "${AppConstants.countryImageUrl}jpn.svg",
    //   LocaleKeys.japanese.value,
    //   'jp',
    //   false,
    // ),
  ];

  // String getCountryName(String countryCode) {
  //   final Map<String, String> countryCodes = {
  //     'US': 'United States',
  //     'CA': 'Canada',
  //     'GB': 'United Kingdom',
  //     'JP': 'Japanese',
  //     // Add more country codes and names as needed
  //   };

  //   return countryCodes[countryCode.toUpperCase()] ?? 'Unknown country';
  // }
}

// String getLanguageName(String? language) {
//   final a = language?.substring(language.lastIndexOf('/') + 1);
//   switch (a) {
//     case "en-US.json":
//       return "English(US)";

//     case "ne-NP.json":
//       return "Nepali";

//     case "ja-JP.json":
//       return "Japanese(JP)";

//     default:
//       return "English";
//   }
// }
