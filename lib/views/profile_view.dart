import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import '../res/colors.dart';
import '../res/styles.dart';
import '../res/decorations.dart';
import '../view_models/home_controller.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/update_data_sheet.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../res/routes.dart';
import '../view_models/auth_controller.dart';
import '../utils/app_toast.dart';
import 'privacy_policy_view.dart'; // Added import

class ProfileView extends GetView<HomeController> {
  const ProfileView({Key? key}) : super(key: key);

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (kIsWeb) {
        // For web we only store the network path / blob URL or file path might not work correctly across reloads without proper storage
        // Assuming we use path here just to show it temporarily on web, or the user can connect it to Firebase Storage later
        controller.updateProfileImage(image.path);
      } else {
        controller.updateProfileImage(image.path);
      }
    }
  }

  void _editNameDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: controller.userName.value);
    CustomBottomSheet.show(
      title: 'Edit Name',
      content: TextField(
        controller: nameController,
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          hintText: 'Enter your name',
          hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark 
              ? Colors.white.withValues(alpha: 0.05) 
              : Colors.black.withValues(alpha: 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
      primaryButton: ElevatedButton(
        onPressed: () {
          if (nameController.text.trim().isNotEmpty) {
            controller.updateUserName(nameController.text.trim());
            AppToast.showSuccess('Success', 'Name updated successfully');
          }
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      secondaryButton: OutlinedButton(
        onPressed: () => Get.back(),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        child: Text('Cancel', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _editAgeDialog(BuildContext context) {
    final TextEditingController ageController = TextEditingController(text: controller.userAge.value.toString());
    CustomBottomSheet.show(
      title: 'Edit Age',
      content: TextField(
        controller: ageController,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          hintText: 'Enter your age',
          hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark 
              ? Colors.white.withValues(alpha: 0.05) 
              : Colors.black.withValues(alpha: 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
      primaryButton: ElevatedButton(
        onPressed: () {
          if (ageController.text.trim().isNotEmpty) {
            int? parsed = int.tryParse(ageController.text.trim());
            if (parsed != null) {
              controller.updateUserAge(parsed);
              AppToast.showSuccess('Success', 'Age updated successfully');
            }
          }
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      secondaryButton: OutlinedButton(
        onPressed: () => Get.back(),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        child: Text('Cancel', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _editGenderDialog(BuildContext context) {
    CustomBottomSheet.show(
      title: 'Edit Gender',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: ['Male', 'Female', 'Other'].map((g) => ListTile(
          title: Text(g, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
          trailing: Obx(() => controller.userGender.value == g ? const Icon(Icons.check, color: AppColors.primary) : const SizedBox.shrink()),
          onTap: () {
            controller.updateUserGender(g);
            AppToast.showSuccess('Success', 'Gender updated successfully');
            Get.back();
          },
        )).toList(),
      ),
      primaryButton: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text('Close', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _editTargetWeightDialog(BuildContext context) {
    final TextEditingController weightController = TextEditingController(text: controller.targetWeight.value.toString());
    CustomBottomSheet.show(
      title: 'Edit Target Weight',
      content: TextField(
        controller: weightController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          hintText: 'Enter target weight',
          hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark 
              ? Colors.white.withValues(alpha: 0.05) 
              : Colors.black.withValues(alpha: 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
      primaryButton: ElevatedButton(
        onPressed: () {
          if (weightController.text.trim().isNotEmpty) {
            double? parsed = double.tryParse(weightController.text.trim());
            if (parsed != null) {
              controller.updateTargetWeight(parsed);
              AppToast.showSuccess('Success', 'Target weight updated successfully');
            }
          }
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      secondaryButton: OutlinedButton(
        onPressed: () => Get.back(),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        child: Text('Cancel', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _editTargetBmiDialog(BuildContext context) {
    final TextEditingController bmiController = TextEditingController(text: controller.targetBmi.value.toString());
    CustomBottomSheet.show(
      title: 'Edit Target BMI',
      content: TextField(
        controller: bmiController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          hintText: 'Enter target BMI',
          hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.dark 
              ? Colors.white.withValues(alpha: 0.05) 
              : Colors.black.withValues(alpha: 0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
      primaryButton: ElevatedButton(
        onPressed: () {
          if (bmiController.text.trim().isNotEmpty) {
            double? parsed = double.tryParse(bmiController.text.trim());
            if (parsed != null) {
              controller.updateTargetBmi(parsed);
              AppToast.showSuccess('Success', 'Target BMI updated successfully');
            }
          }
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      secondaryButton: OutlinedButton(
        onPressed: () => Get.back(),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        child: Text('Cancel', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _editMeasurementUnitsDialog(BuildContext context) {
    CustomBottomSheet.show(
      title: 'Measurement Units',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() => ListTile(
            title: Text('Metric (kg, cm)', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
            trailing: controller.selectedUnit.value == LengthUnit.cm ? const Icon(Icons.check, color: AppColors.primary) : const SizedBox.shrink(),
            onTap: () {
              controller.selectedUnit.value = LengthUnit.cm;
              AppToast.showSuccess('Success', 'Switched to Metric units');
              Get.back();
            },
          )),
          Obx(() => ListTile(
            title: Text('Imperial (lbs, ft)', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
            trailing: controller.selectedUnit.value == LengthUnit.ft ? const Icon(Icons.check, color: AppColors.primary) : const SizedBox.shrink(),
            onTap: () {
              controller.selectedUnit.value = LengthUnit.ft;
              AppToast.showSuccess('Success', 'Switched to Imperial units');
              Get.back();
            },
          )),
        ],
      ),
      primaryButton: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text('Close', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

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
                        child: Obx(() {
                          final imagePath = controller.profileImagePath.value;
                          ImageProvider imageProvider;
                          if (imagePath.isNotEmpty) {
                            if (kIsWeb) {
                              imageProvider = NetworkImage(imagePath);
                            } else {
                              imageProvider = FileImage(File(imagePath));
                            }
                          } else {
                            imageProvider = const AssetImage('assets/images/user_avatar.png');
                          }
                          return CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.weightCard,
                            backgroundImage: imageProvider,
                            child: imagePath.isEmpty
                                ? Image.asset('assets/images/user_avatar.png', errorBuilder: (c, o, s) => const Icon(Icons.person, size: 60, color: AppColors.primary))
                                : null,
                          );
                        }),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: AppColors.actionButton,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit, color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Name & Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                        controller.userName.value,
                        style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color),
                      )),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _editNameDialog(context),
                        child: const Icon(Icons.edit, size: 20, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _editAgeDialog(context),
                        child: Obx(() => _buildTag("${controller.userAge.value} ${'years'.tr}", AppColors.weightCard, AppColors.primary, true)),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => _editGenderDialog(context),
                        child: Obx(() => _buildTag(controller.userGender.value, AppColors.heightCard, AppColors.secondaryDark, true)),
                      ),
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
                        child: GestureDetector(
                          onTap: () => _editTargetWeightDialog(context),
                          child: Obx(() => _buildGoalCard(
                            icon: Icons.track_changes, 
                            label: 'target_weight'.tr, 
                            value: "${controller.targetWeight.value}", 
                            unit: "kg",
                            color: AppColors.weightCard,
                            context: context
                          )),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _editTargetBmiDialog(context),
                          child: Obx(() => _buildGoalCard(
                            icon: Icons.speed, 
                            label: 'target_bmi'.tr, 
                            value: controller.targetBmi.value.toStringAsFixed(1), 
                            unit: "",
                            color: AppColors.heightCard,
                            context: context
                          )),
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
                  Obx(() => _buildMenuItem(
                    Icons.straighten, 
                    'measurement_units'.tr, 
                    controller.selectedUnit.value == LengthUnit.cm ? 'Metric (kg, cm)' : 'Imperial (lbs, ft)', 
                    context, 
                    onTap: () {
                      _editMeasurementUnitsDialog(context);
                    }
                  )),
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
                    Get.to(() => const PrivacyPolicyView());
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
                             Get.find<AuthController>().logout();
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

  Widget _buildTag(String text, Color bgColor, Color textColor, [bool isEditable = false]) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 12),
          ),
          if (isEditable) ...[
            const SizedBox(width: 6),
            Icon(Icons.edit, size: 12, color: textColor.withValues(alpha: 0.7)),
          ]
        ],
      ),
    );
  }

  Widget _buildGoalCard({required IconData icon, required String label, required String value, required String unit, required Color color, required BuildContext context}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.textPrimary;
    final iconBg = isDark ? Colors.white.withValues(alpha: 0.1) : AppColors.primary.withValues(alpha: 0.1);
    final iconColor = isDark ? Colors.white : AppColors.primary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppDecorations.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              Icon(Icons.edit, size: 16, color: isDark ? Colors.white.withValues(alpha: 0.5) : AppColors.textSecondary.withValues(alpha: 0.5)),
            ],
          ),
          const SizedBox(height: 15),
          Text(label, style: TextStyle(color: isDark ? Colors.white.withValues(alpha: 0.7) : AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              Text(unit, style: TextStyle(color: isDark ? Colors.white.withValues(alpha: 0.7) : AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
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
                  color: isDark ? Colors.white.withValues(alpha: 0.1) : AppColors.primary.withValues(alpha: 0.1), 
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
                    Text(subtitle, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7), fontSize: 13)),
                  ],
                ),
              ),
              if (isToggle)
                Switch(
                  value: toggleValue, 
                  onChanged: onToggle,
                  activeThumbColor: AppColors.primary, // activeColor likely not deprecated for Switch in all versions, but verify context. Log says line 294.
                  activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
                )
              else
                 Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.5)),
            ],
          ),
        ),
      ),
    );
  }

}
