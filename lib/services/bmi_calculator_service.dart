import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../constants/bmi_constants.dart';

class BmiCalculatorService {
  
  double calculateBMI(double heightCm, double weightKg) {
    double heightInMeters = heightCm / 100;
    return weightKg / (heightInMeters * heightInMeters);
  }

  String getBmiStatus(double bmi) {
    if (bmi < BmiConstants.underweightThreshold) return "Underweight";
    if (bmi < BmiConstants.normalThreshold) return "Normal";
    if (bmi < BmiConstants.overweightThreshold) return "Overweight";
    return "Obese";
  }

  Color getBmiColor(double bmi) {
    if (bmi < BmiConstants.underweightThreshold) return AppColors.primaryLight;
    if (bmi < BmiConstants.normalThreshold) return AppColors.statusGreen;
    if (bmi < BmiConstants.overweightThreshold) return AppColors.statusOrange;
    return AppColors.statusRed;
  }

  String getBmiAdvice(double bmi) {
    if (bmi < BmiConstants.underweightThreshold) return "You have a lower than normal body weight. You can eat a bit more.";
    if (bmi < BmiConstants.normalThreshold) return "You have a normal body weight. Good job!";
    if (bmi < BmiConstants.overweightThreshold) return "You have a higher than normal body weight. Try to exercise more.";
    return "You have a much higher than normal body weight. Please consult a doctor.";
  }
}
