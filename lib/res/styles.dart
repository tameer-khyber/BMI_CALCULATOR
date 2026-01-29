import 'package:google_fonts/google_fonts.dart'; // We'll need to add this to pubspec if not present, or fallback to standard fonts
import 'package:flutter/material.dart';
import 'colors.dart';

class AppStyles {
  AppStyles._();

  // Dashboard Header
  static TextStyle get dashboardTitle => const TextStyle(
    color: AppColors.primary,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  static TextStyle get welcomeText => const TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // Card Content
  static TextStyle get cardLabel => const TextStyle( 
    color: AppColors.textInverse,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  static TextStyle get bmiBigNumber => const TextStyle(
    color: AppColors.textInverse,
    fontSize: 64,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get bmiStatus => const TextStyle(
    color: AppColors.textInverse,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // Input Cards
  static TextStyle get inputLabel => const TextStyle(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get inputValue => const TextStyle(
    color: AppColors.textPrimary,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle get inputUnit => const TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  // Buttons
  static TextStyle get buttonText => const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );
  
  // Section Headers
  static TextStyle get sectionHeader => const TextStyle(
    color: AppColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  
  static TextStyle get seeAll => const TextStyle(
    color: AppColors.primary,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  );

  static TextStyle get bigNumber => inputValue;
  static TextStyle get unitLabel => inputUnit;
}
