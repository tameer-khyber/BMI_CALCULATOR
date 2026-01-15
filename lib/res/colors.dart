import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  static const Color darkRed = Color(0xFF780000);
  static const Color red = Color(0xFFC1121F);
  static const Color cream = Color(0xFFFDF0D5);
  static const Color darkBlue = Color(0xFF003049);
  static const Color lightBlue = Color(0xFF669BBC);

  // Semantic Aliases
  static const Color primary = darkBlue;
  static const Color accent = lightBlue;
  static const Color background = cream;
  static const Color error = red;
  static const Color textPrimary = darkBlue;
  static const Color textSecondary = lightBlue;
  static const Color selected = lightBlue; // "Primary Blue" for selected state
}
