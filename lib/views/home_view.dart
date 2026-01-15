import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../view_models/home_controller.dart';
import '../widgets/gender_selector.dart';
import '../widgets/height_slider.dart';
import '../widgets/counter_card.dart';
import '../widgets/primary_button.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI CALCULATOR"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Settings logic
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Gender Selector
              Obx(() => GenderSelector(
                    selectedGender: controller.selectedGender.value,
                    onSelect: controller.updateGender,
                  )),
              
              const SizedBox(height: 20),

              // Height Slider
              Obx(() => HeightSlider(
                    height: controller.height.value,
                    onChanged: controller.updateHeight,
                    isCm: controller.selectedUnit.value == LengthUnit.cm,
                    onToggleUnit: controller.toggleUnit,
                  )),

              const SizedBox(height: 20),

              // Weight & Age Row
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() => CounterCard(
                            label: "WEIGHT",
                            value: controller.weight.value,
                            onIncrement: controller.incrementWeight,
                            onDecrement: controller.decrementWeight,
                          )),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Obx(() => CounterCard(
                            label: "AGE",
                            value: controller.age.value,
                            onIncrement: controller.incrementAge,
                            onDecrement: controller.decrementAge,
                          )),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // CTA Button
              PrimaryButton(
                label: "CALCULATE YOUR BMI",
                onPressed: () {
                  // Calculate logic
                  final bmi = controller.calculateBMI;
                  Get.snackbar(
                    "BMI Calculated",
                    "Your BMI is ${bmi.toStringAsFixed(1)}",
                    backgroundColor: AppColors.textPrimary,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(20),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
