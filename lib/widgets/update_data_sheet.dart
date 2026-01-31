import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../view_models/home_controller.dart';
import 'primary_button.dart';

class UpdateDataSheet extends GetView<HomeController> {
  const UpdateDataSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Local text controllers to handle input editing before saving
    // initializing them with current controller values
    final weightController = TextEditingController(text: controller.weight.value.toString());
    final heightController = TextEditingController(text: controller.height.value.toInt().toString());

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

                // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  'update_data_title'.tr,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 18, color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          
          // Unit Toggle
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(() => Row(
              children: [
                _buildToggleOption(
                  'metric_units'.tr, 
                  controller.selectedUnit.value == LengthUnit.cm, 
                  () => controller.selectedUnit.value = LengthUnit.cm
                ),
                _buildToggleOption(
                  'imperial_units'.tr, 
                  controller.selectedUnit.value == LengthUnit.ft, 
                  () => controller.selectedUnit.value = LengthUnit.ft
                ),
              ],
            )),
          ),
          const SizedBox(height: 20),

          // Inputs
          Row(
            children: [
              // Weight Input
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.weightCard,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.monitor_weight_outlined, size: 16, color: AppColors.primary),
                          ),
                          const SizedBox(width: 8),
                          const SizedBox(width: 8),
                          Flexible(child: Text('current_weight'.tr, style: AppStyles.inputLabel.copyWith(fontSize: 12))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: weightController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: AppStyles.inputValue.copyWith(fontSize: 24),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          Obx(() => Text(
                            controller.selectedUnit.value == LengthUnit.cm ? "KG" : "LBS", 
                            style: AppStyles.inputUnit
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              // Height Input
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.heightCard,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.height_rounded, size: 16, color: AppColors.secondaryDark),
                          ),
                          const SizedBox(width: 8),
                          const SizedBox(width: 8),
                          Flexible(child: Text('current_height'.tr, style: AppStyles.inputLabel.copyWith(fontSize: 12))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              style: AppStyles.inputValue.copyWith(fontSize: 24),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          Obx(() => Text(
                            controller.selectedUnit.value == LengthUnit.cm ? "CM" : "FT", 
                            style: AppStyles.inputUnit
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Save Button
          PrimaryButton(
            onPressed: () {
              // Save logic
              if (weightController.text.isNotEmpty) {
                controller.weight.value = double.parse(weightController.text);
              }
              if (heightController.text.isNotEmpty) {
                controller.height.value = double.parse(heightController.text);
              }
              Get.back();
              Get.snackbar('success_title'.tr, 'data_updated_msg'.tr, 
                backgroundColor: AppColors.success, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(20));
            },
            icon: Icons.save_rounded,
            label: 'save_changes'.tr,
            backgroundColor: AppColors.actionButton,
            height: 56, // Matching standard button height or slightly smaller if needed
          ),
          const SizedBox(height: 20),
          Center(
            child: Obx(() {
                if (controller.historyController.history.isEmpty) {
                  return const SizedBox.shrink(); 
                }
                final lastDate = controller.historyController.history.first.date;
                 // Simple formatting - normally use intl or timeago
                final timeStr = "${lastDate.day}/${lastDate.month}/${lastDate.year}";
                return Text(
                  'last_updated_at'.trParams({'time': timeStr}),
                  style: GoogleFonts.poppins(color: AppColors.textSecondary, fontSize: 12),
                );
              }),
          ),
          
          const SizedBox(height: 10), // Bottom safe area spacing
          
        ],
      ),
      ),
    );
  }

  Widget _buildToggleOption(String text, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ] : null,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
