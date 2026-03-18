import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/colors.dart';

class AppToast {
  static void showSuccess(String title, String message) {
    _showToast(title, message, Icons.check_circle_outline, Colors.green);
  }

  static void showError(String title, String message) {
    _showToast(title, message, Icons.error_outline, Colors.redAccent);
  }

  static void showInfo(String title, String message) {
    _showToast(title, message, Icons.info_outline, AppColors.primary);
  }

  static void _showToast(String title, String message, IconData icon, Color color) {
    final isDark = Get.theme.brightness == Brightness.dark;
    
    Get.rawSnackbar(
      titleText: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          color: isDark ? Colors.white70 : Colors.black54,
          fontSize: 13,
        ),
      ),
      icon: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(icon, color: color, size: 28),
      ),
      shouldIconPulse: true,
      backgroundColor: isDark 
          ? const Color(0xFF1E1E1E).withValues(alpha: 0.95) 
          : Colors.white.withValues(alpha: 0.95),
      barBlur: 20,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      boxShadows: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 10,
          spreadRadius: 2,
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 20,
          spreadRadius: 5,
        ),
      ],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}
