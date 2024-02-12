import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

class AppTextTheme {
  static TextStyle heading1 = GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w900,
      color: AppTheme.textColorPrimary);
  static TextStyle heading2 =
      heading1.copyWith(fontSize: 18, fontWeight: FontWeight.w900);
  static TextStyle heading3 =
      heading1.copyWith(fontSize: 17, fontWeight: FontWeight.w700);
  static TextStyle heading4 =
      heading1.copyWith(fontSize: 17, fontWeight: FontWeight.w400);
  static TextStyle heading5 =
      heading1.copyWith(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle title =
      heading1.copyWith(fontSize: 13, fontWeight: FontWeight.w500);

  static TextStyle bodyStyle = GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppTheme.textColorPrimary);
  static TextStyle bodyLightStyle =
      GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w300);

  static TextStyle bodySmallStyle = GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w300,
      color: AppTheme.textColorPrimary);

  static TextStyle bodySmallExtraLightStyle =
      GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w100);

  static TextStyle fancyTextStyle = GoogleFonts.autourOne(
      color: AppTheme.textColorPrimary,
      fontWeight: FontWeight.w700,
      fontSize: 18);
}
