import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF2D3748);
  static const Color accentColor = Color(0xFFE2E8F0);
  static const Color backgroundColor = Color(0xFFF7FAFC);
  static const Color textColor = Color(0xFF212121);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.archivo(color: textColor),
      bodyMedium: GoogleFonts.archivo(color: textColor),
      headlineLarge: GoogleFonts.archivo(
        color: textColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.archivo(
        color: textColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.archivo(color: textColor, fontSize: 16),
      titleSmall: GoogleFonts.archivo(color: textColor, fontSize: 14),
    ),
    appBarTheme: AppBarTheme(color: Colors.transparent),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
