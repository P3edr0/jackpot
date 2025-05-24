import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

abstract class JackLocalizations {
  static List<LocalizationsDelegate> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    LocalJsonLocalization.delegate,
  ];

  static List<Locale> supportedLocales = [
    const Locale('en'),
    const Locale('pt'),
  ];
}
