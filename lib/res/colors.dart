import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Premium Dashboard Palette
  static const Color primary = Color(0xFF00695C); // Deep Teal/Green for the main card
  static const Color primaryDark = Color(0xFF004D40);
  static const Color accent = Color(0xFF26A69A); // Lighter teal
  
  static const Color background = Color(0xFFF5F7FA); // Light Grey/Blue-ish white background
  static const Color surface = Color(0xFFFFFFFF); // White for cards
  
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
}
