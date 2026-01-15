import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.cream,
        error: AppColors.error,
        onPrimary: AppColors.cream,
        onSecondary: AppColors.cream,
        onSurface: AppColors.textPrimary,
        onError: AppColors.cream),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.textPrimary,
      inactiveTrackColor: AppColors.textSecondary.withOpacity(0.3),
      thumbColor: AppColors.red,
      overlayColor: AppColors.red.withOpacity(0.2),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.cream,
    ),
    useMaterial3: true,
  );
}
