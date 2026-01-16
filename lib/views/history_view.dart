import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../view_models/history_controller.dart'; // Assuming this exists or we use HomeController
import '../widgets/custom_bottom_nav.dart';
import '../res/routes.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controller for logic (using existing or new local logic for filters)
    final filter = "All Time".obs;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                          const Text(
                            "Measurement History",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Track your progress over time",
                            style: AppStyles.welcomeText,
                          ),
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
                        child: const Icon(Icons.filter_list_rounded, color: AppColors.primary, size: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Filters
                  Obx(() => Row(
                    children: [
                      _buildFilterChip("All Time", filter.value == "All Time", () => filter.value = "All Time"),
                      const SizedBox(width: 10),
                      _buildFilterChip("Monthly", filter.value == "Monthly", () => filter.value = "Monthly"),
                      const SizedBox(width: 10),
                      _buildFilterChip("Weekly", filter.value == "Weekly", () => filter.value = "Weekly"),
                    ],
                  )),
                  const SizedBox(height: 20),

                  // History List
                  // Mock Data matching the image
                  _buildHistoryCard(
                    date: "Oct 24, 2023",
                    time: "08:30 AM",
                    weight: "68.5",
                    bmi: "22.4",
                    status: "HEALTHY",
                    statusColor: AppColors.success,
                  ),
                  const SizedBox(height: 15),
                  _buildHistoryCard(
                    date: "Oct 18, 2023",
                    time: "07:45 AM",
                    weight: "76.2",
                    bmi: "25.1",
                    status: "OVERWEIGHT",
                    statusColor: AppColors.secondaryDark,
                  ),
                  const SizedBox(height: 15),
                  _buildHistoryCard(
                    date: "Oct 10, 2023",
                    time: "09:15 AM",
                    weight: "77.5",
                    bmi: "25.4",
                    status: "OVERWEIGHT",
                    statusColor: AppColors.secondaryDark,
                  ),
                  const SizedBox(height: 15),
                  _buildHistoryCard(
                    date: "Sep 28, 2023",
                    time: "08:00 AM",
                    weight: "78.1",
                    bmi: "25.6",
                    status: "OVERWEIGHT",
                    statusColor: AppColors.secondaryDark,
                  ),
                ],
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
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: isSelected ? null : Border.all(color: Colors.transparent), // Keep size consistent
             boxShadow: isSelected ? [
              BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))
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

  Widget _buildHistoryCard({
    required String date,
    required String time,
    required String weight,
    required String bmi,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
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
                      color: AppColors.background,
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
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
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
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
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
                  const Text("WEIGHT", style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  const SizedBox(height: 5),
                  Row(
                     crossAxisAlignment: CrossAxisAlignment.baseline,
                     textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(weight, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      const SizedBox(width: 4),
                      const Text("kg", style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
               Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("BMI SCORE", style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  const SizedBox(height: 5),
                  Text(bmi, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: statusColor)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
