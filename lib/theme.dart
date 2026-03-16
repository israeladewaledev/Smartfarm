import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF397454);
  static const Color primaryLight = Color(0xFFE8F5E9);
  
  // Light Theme Tokens
  static const Color backgroundLight = Color(0xFFF9FBFA);
  static const Color surfaceLight = Colors.white;
  static const Color textMainLight = Color(0xFF121714);
  static const Color textSecondaryLight = Color(0xFF638371);

  // Dark Theme Tokens
  static const Color backgroundDark = Color(0xFF161C19);
  static const Color surfaceDark = Color(0xFF222B26);
  static const Color textMainDark = Color(0xFFE0E6E3);
  static const Color textSecondaryDark = Color(0xFF9AB0A3);

  static const Color alertRed = Color(0xFFE53935);
  static const Color warningYellow = Color(0xFFFFB300);

  // Legacy Theme Tokens for backwards compatibility
  static const Color surface = Colors.white;
  static const Color textDark = Color(0xFF121714);
  static const Color textLight = Color(0xFF638371);
}

class AppStyles {
  static TextStyle header(BuildContext context) => GoogleFonts.manrope(
    fontSize: 24, 
    fontWeight: FontWeight.bold,
    color: Theme.of(context).brightness == Brightness.light ? AppColors.textMainLight : AppColors.textMainDark,
  );

  static TextStyle subheader(BuildContext context) => GoogleFonts.manrope(
    fontSize: 14, 
    color: Theme.of(context).brightness == Brightness.light ? AppColors.textSecondaryLight : AppColors.textSecondaryDark,
  );

  static TextStyle cardValue(BuildContext context) => GoogleFonts.manrope(
    fontSize: 28, 
    fontWeight: FontWeight.bold,
    color: Theme.of(context).brightness == Brightness.light ? AppColors.textMainLight : AppColors.textMainDark,
  );
}
