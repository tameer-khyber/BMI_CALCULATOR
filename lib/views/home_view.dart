import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../view_models/home_controller.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/update_data_sheet.dart';
import 'result_view.dart'; // Keep for navigation if needed, though flow might change
import '../res/routes.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100), // Bottom padding for nav bar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 30),
                  _buildMainBMICard(),
                  const SizedBox(height: 20),
                  _buildStatsGrid(),
                  const SizedBox(height: 20),
                  _buildActionButton(),
                  const SizedBox(height: 30),
                  _buildRecentProgress(),
                ],
              ),
            ),
            
            // Bottom Navigation
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNav(
                selectedIndex: 0,
                onTap: (index) {
                   if (index == 1) Get.toNamed(AppRoutes.statistics);
                   if (index == 2) Get.toNamed(AppRoutes.healthInsights);
                   if (index == 3) Get.toNamed(AppRoutes.history);
                   if (index == 4) Get.toNamed(AppRoutes.profile);
                   if (index == 5) Get.toNamed(AppRoutes.settings);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "BMI Calculator",
              style: AppStyles.dashboardTitle,
            ),
            const SizedBox(height: 4),
            Text(
              "Welcome back, User!",
              style: AppStyles.welcomeText,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget _buildMainBMICard() {
    return Obx(() {
      final bmi = controller.calculateBMI;
      // Determine status color/text based on BMI (simplified logic for UI demo)
      String status = "Healthy Weight";
      Color statusColor = AppColors.success;
      if (bmi < 18.5) {
        status = "Underweight";
        statusColor = AppColors.warning;
      } else if (bmi > 25) {
        status = "Overweight";
        statusColor = AppColors.error;
      }

      return GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.statistics),
        child: DashboardCard(
          color: AppColors.primary,
          padding: const EdgeInsets.all(24),
          child: Stack(
            children: [
              // Decorative background circle
              Positioned(
                right: -30,
                top: -30,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("CURRENT BMI SCORE", style: AppStyles.cardLabel.copyWith(color: AppStyles.cardLabel.color?.withOpacity(0.7))),
                      const SizedBox(width: 5),
                      const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: AppStyles.bmiBigNumber,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, size: 10, color: statusColor),
                        const SizedBox(width: 8),
                        Text(status, style: AppStyles.bmiStatus),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.white.withOpacity(0.1)),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMiniStat("LAST LOGGED", "2 days ago"),
                      _buildMiniStat("TARGET BMI", "21.5"),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildMiniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.cardLabel.copyWith(fontSize: 10, color: AppStyles.cardLabel.color?.withOpacity(0.6))),
        const SizedBox(height: 4),
        Text(value, style: AppStyles.bmiStatus.copyWith(fontSize: 14)),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => DashboardCard(
            color: AppColors.weightCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.monitor_weight_outlined, color: AppColors.primary, size: 20),
                    const SizedBox(width: 8),
                    Text("Weight", style: AppStyles.inputLabel),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text("${controller.weight.value}", style: AppStyles.inputValue),
                    const SizedBox(width: 4),
                    Text("kg", style: AppStyles.inputUnit),
                  ],
                ),
              ],
            ),
          )),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Obx(() => DashboardCard(
            color: AppColors.heightCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.height_rounded, color: AppColors.secondaryDark, size: 20),
                    const SizedBox(width: 8),
                    Text("Height", style: AppStyles.inputLabel),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text("${controller.height.value.toInt()}", style: AppStyles.inputValue),
                    const SizedBox(width: 4),
                    Text("cm", style: AppStyles.inputUnit),
                  ],
                ),
              ],
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.actionButton.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
           Get.bottomSheet(
             const UpdateDataSheet(),
             isScrollControlled: true,
             backgroundColor: Colors.transparent,
           );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.actionButton,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.edit_calendar_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Text("Update My Data", style: AppStyles.buttonText),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentProgress() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent Progress", style: AppStyles.sectionHeader),
            TextButton(
              onPressed: () {},
              child: Text("SEE ALL", style: AppStyles.seeAll),
            ),
          ],
        ),
        const SizedBox(height: 10),
        DashboardCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              InkWell(
                onTap: () => Get.toNamed(AppRoutes.profile),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                    ],
                  ),
                  child: const Icon(Icons.person_outline_rounded, color: AppColors.primary, size: 24),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Oct 24, 2023", style: AppStyles.inputLabel),
                  const SizedBox(height: 4),
                  Text("Weight: 69.2 kg", style: AppStyles.welcomeText),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("22.6", style: AppStyles.inputLabel.copyWith(color: AppColors.primary)),
                  const SizedBox(height: 4),
                  Text("BMI", style: AppStyles.inputUnit.copyWith(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
