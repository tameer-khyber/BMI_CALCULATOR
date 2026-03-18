import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../view_models/home_controller.dart';
import '../widgets/primary_button.dart';
import '../constants/bmi_constants.dart';

class ResultView extends GetView<HomeController> {
  final double bmi;

  const ResultView({Key? key, required this.bmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = controller.getBmiStatus(bmi);
    final statusColor = controller.getBmiColor(bmi);
    final advice = controller.getBmiAdvice(bmi);

    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("YOUR RESULT", style: AppStyles.dashboardTitle.copyWith(fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Get.theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ZoomIn(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            status.toUpperCase(),
                            style: GoogleFonts.poppins(
                              color: statusColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            bmi.toStringAsFixed(1),
                            style: GoogleFonts.poppins(
                              color: Get.theme.textTheme.bodyLarge?.color,
                              fontSize: 80,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      
                      Column(
                        children: [
                          const Text(
                            "Normal BMI range:",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${BmiConstants.underweightThreshold} - ${BmiConstants.normalThreshold} kg/m2",
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      
                      // Visual Gauge
                      SizedBox(
                        height: 150,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 10,
                              maximum: 40,
                              startAngle: 180,
                              endAngle: 0,
                              showLabels: false,
                              showTicks: false,
                              radiusFactor: 0.9,
                              axisLineStyle: AxisLineStyle(
                                thickness: 20,
                                cornerStyle: CornerStyle.bothCurve,
                                color: Get.theme.scaffoldBackgroundColor, 
                              ),
                              ranges: <GaugeRange>[
                                GaugeRange(startValue: 10, endValue: BmiConstants.underweightThreshold, color: AppColors.accent),
                                GaugeRange(startValue: BmiConstants.underweightThreshold, endValue: BmiConstants.normalThreshold, color: AppColors.success),
                                GaugeRange(startValue: BmiConstants.normalThreshold, endValue: BmiConstants.overweightThreshold, color: AppColors.warning),
                                GaugeRange(startValue: BmiConstants.overweightThreshold, endValue: 40, color: AppColors.error),
                              ],
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                  value: bmi,
                                  enableAnimation: true,
                                  animationDuration: 1200, 
                                  needleColor: AppColors.textPrimary,
                                  knobStyle: const KnobStyle(color: AppColors.textPrimary),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            

            
            Expanded(
              flex: 2,
              child: FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Get.theme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      advice,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Get.theme.textTheme.bodyLarge?.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: PrimaryButton(
                  label: "RE-CALCULATE",
                  onPressed: () => Get.back(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
