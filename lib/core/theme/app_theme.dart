import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary purple palette
  static const Color primary = Color(0xFF6B21A8);
  static const Color primaryLight = Color(0xFF9333EA);
  static const Color primaryBright = Color(0xFFA855F7);
  static const Color primaryGlow = Color(0xFF7C3AED);

  // Gradient stops for CTA banner
  static const Color gradientStart = Color(0xFF6B21A8);
  static const Color gradientEnd = Color(0xFF9333EA);

  // Neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF8F7FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE9E3F5);

  // Text
  static const Color textDark = Color(0xFF1A1025);
  static const Color textMedium = Color(0xFF4B3F6B);
  static const Color textLight = Color(0xFF9C8FB8);

  // Stat highlight
  static const Color statValue = Color(0xFF6B21A8);

  // Bottom nav
  static const Color navBackground = Color(0xFFFFFFFF);
  static const Color navActive = Color(0xFF6B21A8);
  static const Color navInactive = Color(0xFFB0A4CC);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.surface,   // ✅ removed deprecated 'background'
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: AppColors.textDark,
          letterSpacing: -0.5,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
          letterSpacing: -0.3,
        ),
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.textMedium,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.textMedium,
        ),
        labelLarge: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.textLight,
          letterSpacing: 0.3,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: AppColors.surface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.navBackground,
        selectedItemColor: AppColors.navActive,
        unselectedItemColor: AppColors.navInactive,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }
}