import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../res/decorations.dart';
import '../view_models/home_controller.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/update_data_sheet.dart';
import '../res/routes.dart';

class ProfileView extends GetView<HomeController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
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
                          Text('user_profile'.tr, style: AppStyles.dashboardTitle.copyWith(color: Theme.of(context).textTheme.titleLarge?.color)),
                          const SizedBox(height: 4),
                          Text('settings_preferences'.tr, style: AppStyles.welcomeText.copyWith(color: Theme.of(context).textTheme.bodyMedium?.color)),
                        ],
                      ),
                      // Moon icon removed as requested
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
                          color: Get.theme.cardColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary, width: 3),
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
                    style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color),
                  )),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTag("${controller.userAge.value} ${'years'.tr}", AppColors.weightCard, AppColors.primary),
                      const SizedBox(width: 10),
                      _buildTag(controller.userGender.value, AppColors.heightCard, AppColors.secondaryDark),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Health Goals
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('health_goals'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color)),
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
                        child: Text('update'.tr, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: _buildGoalCard(
                          icon: Icons.track_changes, 
                          label: 'target_weight'.tr, 
                          value: "${controller.targetWeight.value}", 
                          unit: "kg",
                          color: AppColors.weightCard,
                          context: context
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildGoalCard(
                          icon: Icons.speed, 
                          label: 'target_bmi'.tr, 
                          value: "${controller.targetBmi.value}", 
                          unit: "",
                          color: AppColors.heightCard,
                          context: context
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Preferences
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('preferences'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color)),
                  ),
                  const SizedBox(height: 15),
                  _buildMenuItem(Icons.straighten, 'measurement_units'.tr, 'metric_units'.tr, context, onTap: () {
                    Get.snackbar("Preferences", "Unit selection coming soon!", backgroundColor: Theme.of(context).cardColor, colorText: Theme.of(context).textTheme.bodyLarge?.color);
                  }),
                  const SizedBox(height: 15),
                  Obx(() => _buildMenuItem(
                    Icons.notifications_active, 
                    'daily_reminders'.tr, 
                    "8:00 AM", 
                    context,
                    isToggle: true, 
                    toggleValue: controller.notificationsEnabled.value,
                    onToggle: (v) => controller.notificationsEnabled.value = v
                  )),
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                  _buildMenuItem(Icons.lock, 'privacy_security'.tr, 'manage_data'.tr, context, onTap: () {
                    Get.snackbar("Privacy", "Privacy settings coming soon!", backgroundColor: Theme.of(context).cardColor, colorText: Theme.of(context).textTheme.bodyLarge?.color);
                  }),
                  const SizedBox(height: 15),
                  // Log out or button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                          Get.defaultDialog(
                           title: 'sign_out_title'.tr,
                           middleText: 'sign_out_confirm'.tr,
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
                      child: Text('sign_out'.tr, style: GoogleFonts.poppins(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
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
                   if (index == 99) Get.offNamed(AppRoutes.healthInsights);
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

  Widget _buildGoalCard({required IconData icon, required String label, required String value, required String unit, required Color color, required BuildContext context}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.textPrimary;
    final iconBg = isDark ? Colors.white.withOpacity(0.1) : AppColors.primary.withOpacity(0.1);
    final iconColor = isDark ? Colors.white : AppColors.primary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 15),
          Text(label, style: TextStyle(color: isDark ? Colors.white.withOpacity(0.7) : AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Text(unit, style: TextStyle(color: isDark ? Colors.white.withOpacity(0.7) : AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle, BuildContext context, {bool isToggle = false, bool toggleValue = false, Function(bool)? onToggle, VoidCallback? onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isToggle ? () => onToggle?.call(!toggleValue) : onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: AppDecorations.cardDecoration(context),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.1) : AppColors.primary.withOpacity(0.1), 
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: isDark ? Colors.white : AppColors.primary, size: 26),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7), fontSize: 13)),
                  ],
                ),
              ),
              if (isToggle)
                Switch(
                  value: toggleValue, 
                  onChanged: onToggle,
                  activeColor: AppColors.primary,
                  activeTrackColor: AppColors.primary.withOpacity(0.3),
                )
              else
                 Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
            ],
          ),
        ),
      ),
    );
  }

}
