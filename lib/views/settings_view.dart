import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../res/decorations.dart';
import '../widgets/custom_bottom_nav.dart';
import '../res/routes.dart';
import '../view_models/language_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('settings'.tr, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color)),
                  const SizedBox(height: 30),
                  _buildSectionTitle('general'.tr),
                  _buildSettingTile(
                    Icons.language, 
                    'language'.tr, 
                    _getLanguageName(Get.locale?.languageCode),
                    onTap: () => _showLanguageBottomSheet(context)
                  ),
                  _buildSettingTile(Icons.notifications_outlined, 'notifications'.tr, 'on'.tr),
                  _buildSettingTile(Icons.notifications_outlined, 'notifications'.tr, 'on'.tr),
                  _buildPremiumThemeToggle(
                    Get.isDarkMode,
                    (value) => Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionTitle('privacy_security'.tr),
                  _buildSettingTile(Icons.lock_outline, 'privacy_policy'.tr, ""),
                  _buildSettingTile(Icons.help_outline, 'help_support'.tr, ""),
                  const SizedBox(height: 20),
                  _buildSectionTitle('account'.tr),
                  _buildSettingTile(Icons.logout, 'sign_out'.tr, "", isDestructive: true),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNav(
                selectedIndex: 5, // Settings Index
                onTap: (index) {
                   if (index == 0) Get.offNamed(AppRoutes.home);
                   if (index == 1) Get.offNamed(AppRoutes.statistics);
                   if (index == 2) Get.offNamed(AppRoutes.healthInsights);
                   if (index == 3) Get.offNamed(AppRoutes.history);
                   if (index == 4) Get.offNamed(AppRoutes.profile);
                   if (index == 99) Get.offNamed(AppRoutes.healthInsights);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String value, {bool isDestructive = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: isDestructive ? AppColors.error : AppColors.primary),
          const SizedBox(width: 15),
          Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: isDestructive ? AppColors.error : Get.theme.textTheme.bodyLarge?.color))),
          if (value.isNotEmpty)
            Text(value, style: TextStyle(color: Get.theme.textTheme.bodySmall?.color ?? AppColors.textSecondary, fontWeight: FontWeight.w500)),
          const SizedBox(width: 10),
          if (!isDestructive) Icon(Icons.arrow_forward_ios, size: 16, color: Get.theme.iconTheme.color?.withOpacity(0.5)),
        ],
      ),
    ), // Close Container
    ); // Close GestureDetector
  }
  Widget _buildPremiumThemeToggle(bool isDark, Function(bool) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!isDark),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(20),
        decoration: AppDecorations.glassMorphismDecoration(context),
        child: Row(
          children: [
            // Animated Icon Container
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(turns: animation, child: FadeTransition(opacity: animation, child: child));
                },
                child: isDark 
                  ? const Icon(Icons.nightlight_round, key: ValueKey('moon'), color: Color(0xFF7AA2F7), size: 28)
                  : const Icon(Icons.wb_sunny_rounded, key: ValueKey('sun'), color: Colors.orange, size: 28),
              ),
            ),
            const SizedBox(width: 20),
            
            // Text Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'appearance'.tr,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isDark ? 'dark_mode_active'.tr : 'light_mode_active'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: isDark ? Colors.white70 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            // Custom Switch Indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 50,
              height: 30,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDark ? const Color(0xFF7AA2F7) : Colors.grey[300],
              ),
              child: Align(
                alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  

  String _getLanguageName(String? code) {
    switch (code) {
      case 'es': return 'Español';
      case 'fr': return 'Français';
      case 'hi': return 'Hindi';
      case 'zh': return 'Chinese';
      case 'ar': return 'Arabic';
      default: return 'English';
    }
  }

  void _showLanguageBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('select_language'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color)),
            const SizedBox(height: 20),
            _buildLanguageOption(context, "English", "en", "US"),
            _buildLanguageOption(context, "Español", "es", "ES"),
            _buildLanguageOption(context, "Français", "fr", "FR"),
            _buildLanguageOption(context, "Hindi", "hi", "IN"),
            _buildLanguageOption(context, "Chinese", "zh", "CN"),
            _buildLanguageOption(context, "Arabic", "ar", "SA"),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String name, String langCode, String countryCode) {
    final languageController = Get.find<LanguageController>();
    final isSelected = Get.locale?.languageCode == langCode;
    
    return ListTile(
      onTap: () {
        languageController.updateLocale(langCode, countryCode);
        Get.back();
      },
      title: Text(name, style: TextStyle(
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? AppColors.primary : Theme.of(context).textTheme.bodyLarge?.color,
      )),
      trailing: isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
    );
  }
}
