import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../view_models/home_controller.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/update_data_sheet.dart';
import '../res/routes.dart';

class ProfileView extends GetView<HomeController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("User Profile", style: AppStyles.dashboardTitle),
                          const SizedBox(height: 4),
                          Text("Settings & Preferences", style: AppStyles.welcomeText),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                          ],
                        ),
                        child: const Icon(Icons.nightlight_round, color: AppColors.primary, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Avatar Section
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.weightCard,
                          // transform: Matrix4.rotationY(3.14), // Mirror to look like the image if needed
                          child: Image.asset('assets/images/user_avatar.png', errorBuilder: (c,o,s) => const Icon(Icons.person, size: 60, color: AppColors.primary)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.actionButton,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Name & Details
                  Obx(() => Text(
                    controller.userName.value,
                    style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTag("${controller.userAge.value} Years", AppColors.weightCard, AppColors.primary),
                      const SizedBox(width: 10),
                      _buildTag(controller.userGender.value, AppColors.heightCard, AppColors.secondaryDark),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Health Goals
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Health Goals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      TextButton(
                        onPressed: () {
                           // reusing the UpdateDataSheet for now as a demo
                           // or could specific health goal sheet
                           Get.bottomSheet(
                             const UpdateDataSheet(),
                             isScrollControlled: true,
                             backgroundColor: Colors.transparent,
                           );
                        },
                        child: Text("UPDATE", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: _buildGoalCard(
                          icon: Icons.track_changes, 
                          label: "Target Weight", 
                          value: "${controller.targetWeight.value}", 
                          unit: "kg",
                          color: AppColors.weightCard
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildGoalCard(
                          icon: Icons.speed, 
                          label: "Target BMI", 
                          value: "${controller.targetBmi.value}", 
                          unit: "",
                          color: AppColors.heightCard
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Preferences
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Preferences", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  ),
                  const SizedBox(height: 15),
                  _buildMenuItem(Icons.straighten, "Measurement Units", "Metric (kg, cm)", onTap: () {
                    Get.snackbar("Preferences", "Unit selection coming soon!", backgroundColor: Colors.white, colorText: AppColors.textPrimary);
                  }),
                  const SizedBox(height: 15),
                  Obx(() => _buildMenuItem(
                    Icons.notifications_active, 
                    "Daily Reminders", 
                    "8:00 AM", 
                    isToggle: true, 
                    toggleValue: controller.notificationsEnabled.value,
                    onToggle: (v) => controller.notificationsEnabled.value = v
                  )),
                  const SizedBox(height: 15),
                  _buildMenuItem(Icons.lock, "Privacy & Security", "Manage your data", onTap: () {
                    Get.snackbar("Privacy", "Privacy settings coming soon!", backgroundColor: Colors.white, colorText: AppColors.textPrimary);
                  }),
                  const SizedBox(height: 15),
                  // Log out or button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                         Get.defaultDialog(
                           title: "Sign Out",
                           middleText: "Are you sure you want to sign out?",
                           confirmTextColor: Colors.white,
                           onConfirm: () {
                             Get.back();
                             Get.offAllNamed(AppRoutes.splash); // Restart app demo
                           },
                           onCancel: () => Get.back(),
                         );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text("Sign Out", style: GoogleFonts.poppins(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                    ),
                  ),

                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNav(
                selectedIndex: 4,
                onTap: (index) {
                   if (index == 0) Get.offNamed(AppRoutes.home);
                   if (index == 1) Get.offNamed(AppRoutes.statistics);
                   if (index == 2) Get.offNamed(AppRoutes.healthInsights);
                   if (index == 3) Get.offNamed(AppRoutes.history);
                   if (index == 5) Get.offNamed(AppRoutes.settings);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }

  Widget _buildGoalCard({required IconData icon, required String label, required String value, required String unit, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(height: 15),
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Text(unit, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, {bool isToggle = false, bool toggleValue = false, Function(bool)? onToggle, VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isToggle ? () => onToggle?.call(!toggleValue) : onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: AppColors.textSecondary, size: 24),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              if (isToggle)
                Switch(
                  value: toggleValue, 
                  onChanged: onToggle,
                  activeColor: AppColors.primary,
                )
              else
                const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
