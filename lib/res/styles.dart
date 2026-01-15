import 'package:flutter/material.dart';
import 'colors.dart';

class AppStyles {
  AppStyles._();

  static const TextStyle header = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static const TextStyle cardLabel = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  );

  static const TextStyle bigNumber = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 50,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle buttonText = TextStyle(
    color: AppColors.cream,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );
  
  static const TextStyle unitLabel = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
