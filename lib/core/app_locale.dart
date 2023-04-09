import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppLocale {
  static const ru = Locale('ru');

  static const supportedLocales = [ru];

  static LocalizationsDelegate<AppLocalizations> get delegate =>
      AppLocalizations.delegate;

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;

  static bool isRu(String localeName) => localeName == 'ru_RU';

  const AppLocale._();
}
