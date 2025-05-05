import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Colors
  static const Color primaryColor = Color(0xFF63BE6A);
  static const Color secondaryColor = Color(0xFF0D2C0F);
  static const Color errorColor = Color(0xFFFF5252);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color surfaceColor = Color(0xFF1E1E1E);
  static const Color cardColor = Color(0xFF18621D);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color secondaryTextColor = Color(0xFFB3B3B3);
  static const Color dividerColor = Color(0xFF3A3A3A);
  static const Color bottomNavBackgroundColor = Color(0xFF1A1A1A);
  static const Color bottomNavSelectedColor = Color(0xFF00BF6D);
  static const Color bottomNavUnselectedColor = Color(0xFF8E8E8E);

  // Text Styles with Tajawal font
  static final TextStyle headline1 = GoogleFonts.tajawal(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static final TextStyle headline2 = GoogleFonts.tajawal(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static final TextStyle headline3 = GoogleFonts.tajawal(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static final TextStyle headline4 = GoogleFonts.tajawal(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static final TextStyle headline5 = GoogleFonts.tajawal(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static final TextStyle headline6 = GoogleFonts.tajawal(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static final TextStyle bodyText1 = GoogleFonts.tajawal(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textColor,
  );

  static final TextStyle bodyText2 = GoogleFonts.tajawal(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textColor,
  );

  static final TextStyle caption = GoogleFonts.tajawal(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: secondaryTextColor,
  );

  static final TextStyle button = GoogleFonts.tajawal(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  // Theme Data
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      surface: surfaceColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textColor,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardColor,
    dividerColor: dividerColor,
    textTheme: TextTheme(
      displayLarge: headline1,
      displayMedium: headline2,
      displaySmall: headline3,
      headlineMedium: headline4,
      headlineSmall: headline5,
      titleLarge: headline6,
      bodyLarge: bodyText1,
      bodyMedium: bodyText2,
      bodySmall: caption,
      labelLarge: button,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: textColor),
      titleTextStyle: headline4,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: bottomNavBackgroundColor,
      selectedItemColor: bottomNavSelectedColor,
      unselectedItemColor: bottomNavUnselectedColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: button,
      ),
    ),
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: GoogleFonts.tajawal(color: secondaryTextColor),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
  );
}
