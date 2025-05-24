import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot/responsiveness/responsive.dart';

abstract class JackFontStyle {
  static TextStyle h0 = GoogleFonts.roboto()
      .copyWith(height: Responsive.getFontValue(60), color: Colors.black);
  static TextStyle titleLarge = GoogleFonts.roboto()
      .copyWith(height: Responsive.getFontValue(54), color: Colors.black);

  static TextStyle h1 = GoogleFonts.roboto()
      .copyWith(fontSize: Responsive.getFontValue(50), color: Colors.black);
  static TextStyle h2 = GoogleFonts.roboto()
      .copyWith(fontSize: Responsive.getFontValue(40), color: Colors.black);
  static TextStyle h3 = GoogleFonts.roboto()
      .copyWith(fontSize: Responsive.getFontValue(28), color: Colors.black);
  static TextStyle h4 = GoogleFonts.roboto()
      .copyWith(fontSize: Responsive.getFontValue(20), color: Colors.black);
  static TextStyle bodyLarge = GoogleFonts.roboto()
      .copyWith(fontSize: Responsive.getFontValue(16), color: Colors.black);
  static TextStyle title = GoogleFonts.roboto()
      .copyWith(fontSize: Responsive.getFontValue(18), color: Colors.black);
  static TextStyle body = GoogleFonts.roboto()
      .copyWith(fontSize: Responsive.getFontValue(14), color: Colors.black);
  static TextStyle small = GoogleFonts.roboto()
      .copyWith(fontSize: Responsive.getFontValue(12), color: Colors.black);
  static TextStyle verySmall = GoogleFonts.roboto()
      .copyWith(fontSize: Responsive.getFontValue(10), color: Colors.black);
  static TextStyle h0Bold = GoogleFonts.roboto().copyWith(
      height: Responsive.getFontValue(60),
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle titleLargeBold = GoogleFonts.roboto().copyWith(
      height: Responsive.getFontValue(54),
      color: Colors.black,
      fontWeight: FontWeight.bold);
//+++++++++++++++++++  BOLD FONTS +++++++++++++++++++++++++++++++++++++++
  static TextStyle h1Bold = GoogleFonts.roboto().copyWith(
      fontSize: Responsive.getFontValue(50),
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle h2Bold = GoogleFonts.roboto().copyWith(
      fontSize: Responsive.getFontValue(40),
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle h3Bold = GoogleFonts.roboto().copyWith(
      fontSize: Responsive.getFontValue(28),
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle h4Bold = GoogleFonts.roboto().copyWith(
      fontSize: Responsive.getFontValue(20),
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle bodyLargeBold = GoogleFonts.roboto().copyWith(
      fontSize: Responsive.getFontValue(16),
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle titleBold = GoogleFonts.roboto().copyWith(
      fontSize: Responsive.getFontValue(18),
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle bodyBold = GoogleFonts.roboto().copyWith(
      fontSize: Responsive.getFontValue(14),
      color: Colors.black,
      fontWeight: FontWeight.bold);

  static TextStyle smallBold = GoogleFonts.roboto().copyWith(
      fontSize: Responsive.getFontValue(12),
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle verySmallBold = GoogleFonts.roboto().copyWith(
      fontSize: Responsive.getFontValue(10),
      color: Colors.black,
      fontWeight: FontWeight.bold);
}
