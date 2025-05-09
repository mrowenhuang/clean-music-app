import 'package:clean_music_app/core/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData appTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: AppColor.white,
      fontFamily: GoogleFonts.livvic().fontFamily,
    );
  }
}
