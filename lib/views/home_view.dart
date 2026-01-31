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
import '../widgets/fade_in_slide.dart';
import 'package:intl/intl.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100), // Bottom padding for nav bar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FadeInSlide(delay: 0.1, child: _buildHeader(context)),
                  const SizedBox(height: 30),
                  FadeInSlide(delay: 0.2, child: _buildMainBMICard()),
                  const SizedBox(height: 20),
                  FadeInSlide(delay: 0.3, child: _buildStatsGrid()),
                  const SizedBox(height: 20),
                  FadeInSlide(delay: 0.4, child: _buildActionButton()),
                  const SizedBox(height: 30),
                  FadeInSlide(delay: 0.5, child: _buildRecentProgress()),
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
                   // index 2 is removed
                   if (index == 3) Get.toNamed(AppRoutes.history);
                   if (index == 4) Get.toNamed(AppRoutes.profile);
                   if (index == 5) Get.toNamed(AppRoutes.settings);
                   if (index == 99) {
                     Get.toNamed(AppRoutes.healthInsights);
                   }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'dashboard_title'.tr,
              style: AppStyles.dashboardTitle,
            ),
            const SizedBox(height: 4),
            Text(
              'welcome_message'.tr,
              style: AppStyles.welcomeText,
            ),
          ],
        ),
        Row(
          children: [
             Container(
              decoration: BoxDecoration(
                color: Get.theme.cardTheme.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.notifications_outlined, color: Theme.of(context).iconTheme.color),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                color: Get.theme.cardTheme.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.person_outline_rounded, color: Theme.of(context).iconTheme.color),
                onPressed: () => Get.toNamed(AppRoutes.profile),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildMainBMICard() {
    return Obx(() {
      final bmi = controller.calculateBMI;
      // Determine status color/text based on BMI (simplified logic for UI demo)
      String status = 'healthy_weight'.tr;
      Color statusColor = AppColors.success;
      if (bmi < 18.5) {
        status = 'underweight'.tr;
        statusColor = AppColors.warning;
      } else if (bmi > 25) {
        status = 'overweight'.tr;
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
                    color: Colors.white.withValues(alpha: 0.05),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('current_bmi'.tr, style: AppStyles.cardLabel.copyWith(color: AppStyles.cardLabel.color?.withValues(alpha: 0.7))),
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
                      color: Colors.white.withValues(alpha: 0.15),
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
                  Divider(color: Colors.white.withValues(alpha: 0.1)),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        if (controller.historyController.history.isEmpty) {
                           return _buildMiniStat('last_logged'.tr, "—");
                        }
                        final lastDate = controller.historyController.history.first.date;
                        // Simple formatting
                        return _buildMiniStat('last_logged'.tr, "${lastDate.day}/${lastDate.month}");
                      }),
                      _buildMiniStat('target_bmi'.tr, "21.5"),
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
        Text(label, style: AppStyles.cardLabel.copyWith(fontSize: 10, color: AppStyles.cardLabel.color?.withValues(alpha: 0.6))),
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
                    Text('weight'.tr, style: AppStyles.inputLabel),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text("${controller.weight.value}", style: AppStyles.inputValue),
                    const SizedBox(width: 4),
                    Obx(() => Text(
                      controller.selectedUnit.value == LengthUnit.cm ? "kg" : "lbs", 
                      style: AppStyles.inputUnit
                    )),
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
                    Text('height'.tr, style: AppStyles.inputLabel),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text("${controller.height.value.toInt()}", style: AppStyles.inputValue),
                    const SizedBox(width: 4),
                    Obx(() => Text(
                      controller.selectedUnit.value == LengthUnit.cm ? "cm" : "ft", 
                      style: AppStyles.inputUnit
                    )),
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
            color: AppColors.actionButton.withValues(alpha: 0.3),
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
            Text('update_data'.tr, style: AppStyles.buttonText),
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
          Text('recent_progress'.tr, style: AppStyles.sectionHeader.copyWith(color: Theme.of(Get.context!).textTheme.titleLarge?.color ?? Theme.of(Get.context!).textTheme.bodyLarge?.color)),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.history),
              child: Text('see_all'.tr, style: AppStyles.seeAll),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Obx(() {
          final history = controller.historyController.history;
          if (history.isEmpty) {
             return DashboardCard(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text('no_history'.tr, style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              ),
            );
          }
          
          // Take top 3 records
          final recent = history.take(3).toList();
          
          return Column(
            children: recent.map((record) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DashboardCard(
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
                              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
                            ],
                          ),
                          child: const Icon(Icons.show_chart_rounded, color: AppColors.primary, size: 24),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat('MMM d, yyyy').format(record.date), style: AppStyles.inputLabel.copyWith(color: Theme.of(Get.context!).textTheme.bodyLarge?.color)),
                          const SizedBox(height: 4),
                          Obx(() => Text(
                            "${'weight'.tr}: ${record.weight} ${controller.selectedUnit.value == LengthUnit.cm ? 'kg' : 'lbs'}", 
                            style: AppStyles.welcomeText.copyWith(color: Theme.of(Get.context!).textTheme.bodyMedium?.color)
                          )),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(record.bmi.toStringAsFixed(1), style: AppStyles.inputLabel.copyWith(color: AppColors.primary)),
                          const SizedBox(height: 4),
                          Text("BMI", style: AppStyles.inputUnit.copyWith(fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
