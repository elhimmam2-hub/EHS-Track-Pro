import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Visual Comfort & Calmness Color Tokens
  static const Color primaryEcoGreen = Color(0xFF0F5238);
  static const Color primaryLight = Color(0xFF2D6A4F);
  static const Color primaryAccent = Color(0xFF40916C);
  
  static const Color secondarySlateBlue = Color(0xFF1D3557);
  static const Color secondaryLight = Color(0xFF457B9D);
  static const Color tertiaryAccent = Color(0xFF064C6C);
  
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color surfaceCardLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121816);
  static const Color surfaceCardDark = Color(0xFF1C2522);

  // Soft Status Alerts (non-glaring)
  static const Color alertWarningAmber = Color(0xFFD97706);
  static const Color alertCoralDanger = Color(0xFFE76F51);
  static const Color alertSafeMint = Color(0xFF52B788);

  static ThemeData lightTheme(String localeCode) {
    final isArabic = localeCode == 'ar';
    final baseTextTheme = isArabic 
        ? GoogleFonts.readexProTextTheme() 
        : GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryEcoGreen,
      scaffoldBackgroundColor: backgroundLight,
      cardColor: surfaceCardLight,
      colorScheme: ColorScheme.light(
        primary: primaryEcoGreen,
        primaryContainer: primaryLight,
        secondary: secondarySlateBlue,
        secondaryContainer: const Color(0xFFDBE4ED),
        surface: surfaceCardLight,
        error: alertCoralDanger,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: const Color(0xFF141D23),
      ),
      textTheme: baseTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: baseTextTheme.titleLarge?.copyWith(
          color: const Color(0xFF141D23),
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: primaryEcoGreen),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryEcoGreen,
        unselectedItemColor: Color(0xFF707973),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  static ThemeData darkTheme(String localeCode) {
    final isArabic = localeCode == 'ar';
    final baseTextTheme = isArabic 
        ? GoogleFonts.readexProTextTheme(ThemeData.dark().textTheme) 
        : GoogleFonts.interTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryAccent,
      scaffoldBackgroundColor: backgroundDark,
      cardColor: surfaceCardDark,
      colorScheme: ColorScheme.dark(
        primary: primaryAccent,
        primaryContainer: primaryLight,
        secondary: secondaryLight,
        surface: surfaceCardDark,
        error: alertCoralDanger,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: const Color(0xFFE9F2FB),
      ),
      textTheme: baseTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF151C1A),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: baseTextTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: primaryAccent),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF151C1A),
        selectedItemColor: primaryAccent,
        unselectedItemColor: Color(0xFF707973),
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
