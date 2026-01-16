import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../widgets/custom_bottom_nav.dart';
import '../res/routes.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Settings", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 30),
                  _buildSectionTitle("General"),
                  _buildSettingTile(Icons.language, "Language", "English"),
                  _buildSettingTile(Icons.notifications_outlined, "Notifications", "On"),
                  _buildSettingTile(Icons.dark_mode_outlined, "Theme", "Light"),
                  const SizedBox(height: 20),
                  _buildSectionTitle("Privacy & Security"),
                  _buildSettingTile(Icons.lock_outline, "Privacy Policy", ""),
                  _buildSettingTile(Icons.help_outline, "Help & Support", ""),
                  const SizedBox(height: 20),
                  _buildSectionTitle("Account"),
                  _buildSettingTile(Icons.logout, "Sign Out", "", isDestructive: true),
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

  Widget _buildSettingTile(IconData icon, String title, String value, {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: isDestructive ? AppColors.error : AppColors.primary),
          const SizedBox(width: 15),
          Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: isDestructive ? AppColors.error : AppColors.textPrimary))),
          if (value.isNotEmpty)
            Text(value, style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
          const SizedBox(width: 10),
          if (!isDestructive) const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
