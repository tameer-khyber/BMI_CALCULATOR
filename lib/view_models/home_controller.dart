import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../res/colors.dart';
import 'history_controller.dart';

enum Gender { male, female }
enum LengthUnit { cm, ft }

class HomeController extends GetxController {
  // Observables
  var selectedGender = Gender.male.obs;
  var height = 170.0.obs; // Stored in cm by default
  var weight = 70.0.obs;
  var age = 25.obs;
  var selectedUnit = LengthUnit.cm.obs;
  
  // Profile Data
  var targetWeight = 65.0.obs;
  var targetBmi = 21.5.obs;
  var notificationsEnabled = true.obs;
  var userName = "Alex Thompson".obs;
  var userAge = 28.obs;
  var userGender = "Male".obs;

  // Actions
  void updateGender(Gender gender) {
    selectedGender.value = gender;
  }

  void updateHeight(double value) {
    height.value = value;
  }

  void toggleUnit() {
    selectedUnit.value = selectedUnit.value == LengthUnit.cm 
        ? LengthUnit.ft 
        : LengthUnit.cm;
  }

  void incrementWeight() => weight.value++;
  void decrementWeight() => weight.value > 1 ? weight.value-- : null;

  void incrementAge() => age.value++;
  void decrementAge() => age.value > 1 ? age.value-- : null;

  final historyController = Get.put(HistoryController());

  double get calculateBMI {
    // BMI = kg / m^2
    double heightInMeters = height.value / 100;
    final bmi = weight.value / (heightInMeters * heightInMeters);
    
    // Save to History
    final status = getBmiStatus(bmi);
    historyController.saveBmi(bmi, status);
    
    return bmi;
  }

  String getBmiStatus(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }

  Color getBmiColor(double bmi) {
    if (bmi < 18.5) return AppColors.primaryLight;
    if (bmi < 25) return AppColors.statusGreen;
    if (bmi < 30) return AppColors.statusOrange;
    return AppColors.statusRed;
  }

  String getBmiAdvice(double bmi) {
    if (bmi < 18.5) return "You have a lower than normal body weight. You can eat a bit more.";
    if (bmi < 25) return "You have a normal body weight. Good job!";
    if (bmi < 30) return "You have a higher than normal body weight. Try to exercise more.";
    return "You have a much higher than normal body weight. Please consult a doctor.";
  }
}
