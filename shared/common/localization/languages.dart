import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

List<LocalizationModel> localizationLanguageList = [
  LocalizationModel(
    locale: const Locale('en', 'US'),
    language: 'English (United States)',
  ),
  LocalizationModel(
    locale: const Locale('th', 'TH'),
    language: 'Thai',
  ),
];

class LocalizationModel {
  Locale locale;
  String language;

  LocalizationModel({
    required this.locale,
    required this.language,
  });

  static LocalizationModel? getLanguageByLocale(Locale locale) {
    return localizationLanguageList.firstWhereOrNull(
      (x) => x.locale.languageCode == locale.languageCode,
    );
  }
}
