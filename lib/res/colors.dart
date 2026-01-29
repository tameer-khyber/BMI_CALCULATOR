import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Premium Dashboard Palette
  static const Color primary = Color(0xFF00695C); // Deep Teal/Green for the main card
  static const Color primaryDark = Color(0xFF004D40);
  static const Color accent = Color(0xFF26A69A); // Lighter teal
  
  static const Color background = Color(0xFFE2E8F0); // Deeper Cool Grey for distinct contrast
  static const Color surface = Color(0xFFFFFFFF); // Pure White for cards
  
  static const Color lightCard = Color(0xFFFFFFFF); 
  static const Color dimWhite = Color(0xFFFFFFFF); // Keep consistant white

  static const Color secondary = Color(0xFFFFCCBC); // Soft Peach/Orange for secondary accents
  static const Color secondaryDark = Color(0xFFFF5722); // Stronger orange
  
  static const Color textPrimary = Color(0xFF102027); // Very dark blue/grey
  static const Color textSecondary = Color(0xFF546E7A); // Muted blue/grey
  static const Color textInverse = Color(0xFFFFFFFF); // White on dark backgrounds

  // Functional Colors
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFD50000);
  
  // Specific UI Elements
  static const Color weightCard = Color(0xFFE0F2F1); // Very light teal
  static const Color heightCard = Color(0xFFFFEBEE); // Very light pink/orange
  static const Color actionButton = Color(0xFFFF5252); // Coral Red for the main button

  // Legacy Compatibility (Mapped to new theme)
  static const Color statusGreen = success;
  static const Color statusOrange = warning;
  static const Color statusRed = error;
  static const Color primaryLight = accent;
  static const Color accentDark = primaryDark;
  static const Color red = error;
  static const Color cream = surface;
  static const Color cardSurface = surface;
  static const Color darkBlue = primaryDark;
  static const Color lightBlue = primary;


  // Dark Mode Palette
  static const Color darkBackground = Color(0xFF0D1B2A); // Deep Navy
  static const Color darkSurface = Color(0xFF1B263B); // Lighter Navy
  static const Color darkAccent = Color(0xFFFF6B6B); // Coral/Red
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFE0E1DD);
}
