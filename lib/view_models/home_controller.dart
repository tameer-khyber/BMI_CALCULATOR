import 'package:get/get.dart';

enum Gender { male, female }
enum LengthUnit { cm, ft }

class HomeController extends GetxController {
  // Observables
  var selectedGender = Gender.male.obs;
  var height = 170.0.obs; // Stored in cm by default
  var weight = 70.obs;
  var age = 25.obs;
  var selectedUnit = LengthUnit.cm.obs;

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

  double get calculateBMI {
    // BMI = kg / m^2
    double heightInMeters = height.value / 100;
    return weight.value / (heightInMeters * heightInMeters);
  }
}
