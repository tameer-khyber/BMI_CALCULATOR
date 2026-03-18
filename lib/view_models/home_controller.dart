import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../res/colors.dart';
import 'history_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/bmi_calculator_service.dart';
import '../constants/bmi_constants.dart';

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
  var targetBmi = BmiConstants.targetBmiDefault.obs;
  var notificationsEnabled = true.obs;
  var userName = "".obs;
  var userAge = 25.obs;
  var userGender = "Male".obs;
  var profileImagePath = "".obs;

  final box = GetStorage();

  /// Returns a storage key scoped to the current Firebase user's UID,
  /// so each user's data is completely isolated on-device.
  String _key(String name) {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
    return '${uid}_$name';
  }

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  /// Loads all profile data for the currently signed-in user.
  /// Call this whenever the active user changes (login / account switch).
  void loadUserProfile() {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    // Use Firebase Auth display name as the canonical name source —
    // it is set during registration and is consistent across devices.
    final firebaseName = firebaseUser?.displayName ?? '';

    userName.value = box.read(_key('userName')) ?? firebaseName;
    profileImagePath.value = box.read(_key('profileImagePath')) ?? '';
    userAge.value = box.read(_key('userAge')) ?? 25;
    userGender.value = box.read(_key('userGender')) ?? 'Male';
    targetWeight.value = box.read(_key('targetWeight')) ?? 65.0;
    targetBmi.value = box.read(_key('targetBmi')) ?? BmiConstants.targetBmiDefault;
  }

  // Actions
  void updateUserName(String name) {
    if (name.isNotEmpty) {
      userName.value = name;
      box.write(_key('userName'), name);
    }
  }

  void updateProfileImage(String path) {
    profileImagePath.value = path;
    box.write(_key('profileImagePath'), path);
  }

  void updateUserAge(int newAge) {
    userAge.value = newAge;
    box.write(_key('userAge'), newAge);
  }

  void updateUserGender(String newGender) {
    if (newGender.isNotEmpty) {
      userGender.value = newGender;
      box.write(_key('userGender'), newGender);
    }
  }

  void updateTargetWeight(double newTargetWeight) {
    targetWeight.value = newTargetWeight;
    box.write(_key('targetWeight'), newTargetWeight);
  }

  void updateTargetBmi(double newTargetBmi) {
    targetBmi.value = newTargetBmi;
    box.write(_key('targetBmi'), newTargetBmi);
  }

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
  final _bmiService = BmiCalculatorService();

  double get calculateBMI {
    return _bmiService.calculateBMI(height.value, weight.value);
  }

  void saveCurrentBmiToHistory() {
    final bmi = _bmiService.calculateBMI(height.value, weight.value);
    final status = getBmiStatus(bmi);
    historyController.saveBmi(bmi, weight.value, status);
  }

  String getBmiStatus(double bmi) => _bmiService.getBmiStatus(bmi);
  Color getBmiColor(double bmi) => _bmiService.getBmiColor(bmi);
  String getBmiAdvice(double bmi) => _bmiService.getBmiAdvice(bmi);
}
