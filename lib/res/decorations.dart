import 'package:flutter/material.dart';
import 'colors.dart';

/// Centralized BoxDecoration utilities for consistent UI theming
/// All card decorations should use these functions for easy theme changes
class AppDecorations {
  AppDecorations._();

  // ━━━ CARD DECORATIONS ━━━

  /// Standard premium card decoration with theme-aware gradient
  /// Used in: Statistics, History, Profile views
  static BoxDecoration cardDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      gradient: LinearGradient(
        colors: isDark 
          ? [const Color(0xFF1B263B), const Color(0xFF253248)] 
          : [Colors.white, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: isDark 
            ? Colors.black.withOpacity(0.2) 
            : Colors.blueGrey.withOpacity(0.08),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
      border: Border.all(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.transparent,
        width: 1,
      ),
    );
  }

  /// Dashboard card decoration (used in Home view for stat cards)
  /// Slightly softer shadow for smaller cards
  static BoxDecoration dashboardCardDecoration(BuildContext context, {Color? color}) {
    return BoxDecoration(
      color: color ?? Theme.of(context).cardTheme.color,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.withOpacity(0.1),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // ━━━ ICON CONTAINERS ━━━

  /// Circular icon container (common pattern across views)
  static BoxDecoration circleIconDecoration(BuildContext context, {Color? bgColor}) {
    return BoxDecoration(
      color: bgColor ?? Theme.of(context).cardColor,
      shape: BoxShape.circle,
    );
  }

  /// Icon container with rounded square background
  static BoxDecoration roundedIconDecoration(BuildContext context, {Color? bgColor}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: bgColor ?? (isDark 
        ? Colors.white.withOpacity(0.1) 
        : AppColors.primary.withOpacity(0.1)),
      borderRadius: BorderRadius.circular(14),
    );
  }

  // ━━━ SPECIAL DECORATIONS ━━━

  /// Premium glassmorphism effect for Settings dark mode toggle
  static BoxDecoration glassMorphismDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      gradient: LinearGradient(
        colors: isDark 
          ? [const Color(0xFF1B263B), const Color(0xFF0D1B2A)] 
          : [Colors.white, const Color(0xFFF0F4F8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: isDark 
            ? Colors.black.withOpacity(0.3) 
            : Colors.blue.withOpacity(0.1),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
      border: Border.all(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        width: 1,
      ),
    );
  }

  /// Filter chip decoration (used in History view)
  static BoxDecoration filterChipDecoration({
    required bool isSelected,
    required BuildContext context,
  }) {
    return BoxDecoration(
      color: isSelected ? AppColors.primary : Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(20),
      border: isSelected ? null : Border.all(color: Colors.transparent),
      boxShadow: isSelected ? [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        )
      ] : null,
    );
  }
}
