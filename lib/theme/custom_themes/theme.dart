import 'package:flutter/material.dart';
import 'package:jackpot/theme/text_theme/text_theme.dart';

class JackAppTheme {
  JackAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color.fromRGBO(31, 154, 30, 1),
    focusColor: Colors.white,
    fontFamily: 'roboto',
    textTheme: JackTextTheme.lightTextTheme,
    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: const Color.fromARGB(1, 31, 154, 30),
    focusColor: Colors.white,
    fontFamily: 'roboto',
    textTheme: JackTextTheme.darkTextTheme,
    useMaterial3: true,
  );
}
