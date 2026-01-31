import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../res/decorations.dart';
import '../view_models/history_controller.dart'; // Assuming this exists or we use HomeController
import '../widgets/custom_bottom_nav.dart';
import '../res/routes.dart';
import 'package:intl/intl.dart';
import '../widgets/fade_in_slide.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    // Controller for logic
    final controller = Get.find<HistoryController>();
    final filter = "All Time".obs;

    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'measurement_history'.tr,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.titleLarge?.color,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'track_progress'.tr,
                            style: AppStyles.welcomeText,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          // Show options bottom sheet
                          Get.bottomSheet(
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Get.theme.scaffoldBackgroundColor,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ListTile(
                                    leading: const Icon(Icons.delete_outline, color: AppColors.error),
                                    title: Text('Clear History', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)), // Using hardcoded or add to messages
                                    onTap: () {
                                      Get.back(); // Close sheet
                                      _showClearHistoryConfirmation(context, controller);
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () => Get.back(), 
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 15),
                                        side: BorderSide(color: AppColors.textSecondary.withValues(alpha: 0.3)),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      child: Text('cancel'.tr, style: TextStyle(color: AppColors.textSecondary)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Get.theme.cardColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
                            ],
                          ),
                          child: const Icon(Icons.filter_list_rounded, color: AppColors.primary, size: 24),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Filters
                  Obx(() => Row(
                    children: [
                      _buildFilterChip('all_time'.tr, filter.value == "All Time", () => filter.value = "All Time"),
                      const SizedBox(width: 10),
                      _buildFilterChip('monthly'.tr, filter.value == "Monthly", () => filter.value = "Monthly"),
                      const SizedBox(width: 10),
                      _buildFilterChip('weekly'.tr, filter.value == "Weekly", () => filter.value = "Weekly"),
                    ],
                  )),
                  const SizedBox(height: 20),

                  // History List
                  Expanded(
                    child: Obx(() {
                      if (controller.history.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.history, size: 60, color: AppColors.textSecondary.withValues(alpha: 0.3)),
                              const SizedBox(height: 10),
                              Text('no_history'.tr, style: TextStyle(color: AppColors.textSecondary)),
                            ],
                          ),
                        );
                      }
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.history.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          final record = controller.history[index];
                          return FadeInSlide(
                            delay: index * 0.1,
                            child: _buildHistoryCard(
                              context,
                              record: record,
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            ),

            // Bottom Nav
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNav(
                selectedIndex: 3, // History Index
                onTap: (index) {
                   if (index == 0) Get.offNamed(AppRoutes.home);
                   if (index == 1) Get.offNamed(AppRoutes.statistics);
                   if (index == 2) Get.offNamed(AppRoutes.healthInsights);
                   if (index == 4) Get.offNamed(AppRoutes.profile);
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

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Get.theme.cardColor,
            borderRadius: BorderRadius.circular(20),
            border: isSelected ? null : Border.all(color: Colors.transparent), // Keep size consistent
             boxShadow: isSelected ? [
              BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))
            ] : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(
    BuildContext context, {
    required BmiRecord record,
  }) {
    final statusColor = _getStatusColor(record.status);
    final date = DateFormat('MMM d, yyyy').format(record.date);
    final time = DateFormat('h:mm a').format(record.date);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppDecorations.cardDecoration(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Get.theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.calendar_today_outlined, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  record.status.toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('weight'.tr.toUpperCase(), style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  const SizedBox(height: 5),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.baseline,
                     textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(record.bmi.toStringAsFixed(1), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                      const SizedBox(width: 4),
                      Text("BMI", style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
               Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('bmi_score'.tr, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  const SizedBox(height: 5),
                  Text(record.bmi.toStringAsFixed(1), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: statusColor)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'underweight': return AppColors.warning;
      case 'normal': return AppColors.success;
      case 'overweight': return AppColors.secondaryDark;
      case 'obese': return AppColors.error;
      default: return AppColors.primary;
    }
  }

  void _showClearHistoryConfirmation(BuildContext context, HistoryController controller) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Get.theme.dialogTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Clear History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color)),
              const SizedBox(height: 15),
              Text('Are you sure you want to delete all history records? This action cannot be undone.', textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                   OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.textSecondary),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('cancel'.tr, style: TextStyle(color: AppColors.textSecondary)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                       Get.back(); // Close dialog
                       controller.clearHistory();
                       Get.snackbar("Success", "History cleared successfully", snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(20), backgroundColor: AppColors.success, colorText: Colors.white, borderRadius: 20);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Clear', style: const TextStyle(color: Colors.white)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
