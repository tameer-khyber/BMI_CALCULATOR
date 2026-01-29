import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../res/decorations.dart';
import '../view_models/home_controller.dart';
import '../widgets/custom_bottom_nav.dart';
import '../res/routes.dart';
import '../view_models/history_controller.dart';
import 'package:collection/collection.dart'; // For average extension if needed, or manual
import 'dart:math';

class StatisticsView extends GetView<HomeController> {
  const StatisticsView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // Get History Controller
    final historyController = Get.find<HistoryController>();
    
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
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
                          Text('stats'.tr, style: AppStyles.dashboardTitle.copyWith(color: Theme.of(context).textTheme.titleLarge?.color)),
                          const SizedBox(height: 4),
                          Text('bmi_analytics'.tr, style: AppStyles.welcomeText),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Get.theme.cardColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
                              ],
                            ),
                            child: const Icon(Icons.notifications_outlined, color: AppColors.primary, size: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // BMI Trends Chart Card
                  Obx(() {
                    if (historyController.history.isEmpty) return const SizedBox.shrink();
                    
                    // Prepare Data: Take last 6 records, reversed (so oldest is left)
                    final data = historyController.history.take(6).toList().reversed.toList();
                    final spots = data.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value.bmi);
                    }).toList();

                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppDecorations.cardDecoration(context),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('bmi_trends'.tr, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text('last_records'.trParams({'count': '${data.length}'}), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 200,
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(show: false),
                                titlesData: FlTitlesData(show: false), // Simplified for standard look
                                borderData: FlBorderData(show: false),
                                minX: 0,
                                maxX: (data.length - 1).toDouble(),
                                minY: 10, 
                                maxY: 40,
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: spots,
                                    isCurved: true,
                                    color: AppColors.primary,
                                    barWidth: 4,
                                    isStrokeCapRound: true,
                                    dotData: FlDotData(show: true),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: AppColors.primary.withValues(alpha: 0.1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildLegendItem(AppColors.primary, 'your_bmi'.tr),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 20),

                  // Average BMI & Weight Change
                  Obx(() {
                    final history = historyController.history;
                      if (history.isEmpty) {
                        return Center(child: Text('no_records_add'.tr, style: TextStyle(color: AppColors.textSecondary)));
                      }

                    // Calculations
                    final avgBmi = history.map((e) => e.bmi).reduce((a, b) => a + b) / history.length;
                    final currentWeight = history.first.weight; // Latest is first usually? Check sorting
                    // History is usually sorted by Date DESC in DB helper
                    final latest = history.first;
                    final oldest = history.last;
                    final weightChange = latest.weight - oldest.weight;
                    final isWeightLoss = weightChange < 0;

                    return Column(
                      children: [
                        // Average BMI
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: AppDecorations.cardDecoration(context),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Get.theme.cardColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(Icons.show_chart_rounded, color: AppColors.primary, size: 28),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text('average_bmi'.tr, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Weight Change
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: AppDecorations.cardDecoration(context),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Get.theme.cardColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(Icons.monitor_weight_outlined, color: AppColors.actionButton, size: 28),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('weight_change_total'.tr, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color ?? AppColors.secondaryDark, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                                      const SizedBox(height: 4),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(weightChange.abs().toStringAsFixed(1), style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 28, fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 4),
                                        Text('weight'.tr, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 16, fontWeight: FontWeight.w600)),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: isWeightLoss ? AppColors.success.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(4)
                                        ),
                                        child: Text(isWeightLoss ? 'lost'.tr : 'gained'.tr, style: TextStyle(color: isWeightLoss ? AppColors.success : AppColors.error, fontSize: 10, fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 20),

                  // Goal Progress
                   Container(
                    padding: const EdgeInsets.all(20),
                    decoration: AppDecorations.cardDecoration(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Get.theme.scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.flag_rounded, color: AppColors.primary, size: 24),
                                ),
                                const SizedBox(width: 12),
                                Text('goal_progress'.tr, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                              ],
                            ),
                            const Text("75%", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 0.75,
                            minHeight: 12,
                            backgroundColor: Get.theme.scaffoldBackgroundColor,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("${'start_label'.tr}: 24.5 BMI", style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.w600)),
                             Text("${'target_label'.tr}: 21.5 BMI", style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ),
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
                selectedIndex: 1, // Analysis/Stats Tab
                onTap: (index) {
                   if (index == 0) Get.offNamed(AppRoutes.home);
                   if (index == 2) Get.offNamed(AppRoutes.healthInsights);
                   if (index == 3) Get.offNamed(AppRoutes.history);
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

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
