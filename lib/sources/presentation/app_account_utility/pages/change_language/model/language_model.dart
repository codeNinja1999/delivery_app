import 'package:flutter/material.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class LanguageModel {
  final String flag;
  final String name;
  final String languageCode;
  final bool isSelected;

  LanguageModel({
    required this.flag,
    required this.name,
    required this.languageCode,
    required this.isSelected,
  });

  factory LanguageModel.fromLanguageList(Locale? currentLocale, Locale? selectedLocale) {
    return LanguageModel(
      flag: "${AppConstants.countryImageUrl}${currentLocale?.countryCode?.toLowerCase() ?? "usa"}.svg",
      name: StringUtils.getCountryName(currentLocale?.countryCode ?? ""),
      languageCode: currentLocale?.languageCode ?? "",
      isSelected: (currentLocale == selectedLocale) ? true : false,
    );
  }
}
