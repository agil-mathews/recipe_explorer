import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Mode Colors
  static const Color primaryLight = Color(0xFFD35400); // Rich Terracotta Orange
  static const Color secondaryLight = Color(0xFFF39C12); // Golden Honey Amber
  static const Color backgroundLight = Color(0xFFFAF9F5); // Soft Linen Off-White
  static const Color surfaceLight = Color(0xFFFFFFFF); // Bright White
  static const Color textDark = Color(0xFF2C3E50); // Charcoal/Navy Slate
  static const Color textLight = Color(0xFF7F8C8D); // Silver Gray

  // Dark Mode Colors
  static const Color primaryDark = Color(0xFFE67E22); // Vibrant Orange
  static const Color secondaryDark = Color(0xFFF1C40F); // Warm Amber
  static const Color backgroundDark = Color(0xFF0C0E10); // True Premium Dark
  static const Color surfaceDark = Color(0xFF16191C); // Sleek Slate Card background
  static const Color textDarkOnLight = Color(0xFFECF0F1); // Light Gray
  static const Color textLightOnLight = Color(0xFF95A5A6); // Slate Silver Gray

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primaryLight,
        secondary: secondaryLight,
        surface: surfaceLight,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textDark,
      ),
      scaffoldBackgroundColor: backgroundLight,
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        displaySmall: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: textDark,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 13,
          color: textLight,
        ),
      ),
      // cardTheme: CardTheme(
      //   color: surfaceLight,
      //   elevation: 2,
      //   shadowColor: Colors.black.withOpacity(0.04),
      //   margin: EdgeInsets.zero,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      // ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textDark),
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryDark,
        secondary: secondaryDark,
        surface: surfaceDark,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: textDarkOnLight,
      ),
      scaffoldBackgroundColor: backgroundDark,
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textDarkOnLight,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textDarkOnLight,
        ),
        displaySmall: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textDarkOnLight,
        ),
        titleLarge: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textDarkOnLight,
        ),
        titleMedium: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textDarkOnLight,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: textDarkOnLight,
        ),
        bodyMedium: GoogleFonts.outfit(
          fontSize: 13,
          color: textLightOnLight,
        ),
      ),
      // cardTheme: CardTheme(
      //   color: surfaceDark,
      //   elevation: 0,
      //   margin: EdgeInsets.zero,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //     side: BorderSide(
      //       color: Colors.white.withOpacity(0.06),
      //       width: 1,
      //     ),
      //   ),
      // ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textDarkOnLight),
        titleTextStyle: TextStyle(
          color: textDarkOnLight,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
