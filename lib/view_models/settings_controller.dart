import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Observables for settings
  final RxBool _notificationsEnabled = true.obs;
  final RxString _unitSystem = 'Metric'.obs; // 'Metric' or 'Imperial'

  // Getters
  bool get notificationsEnabled => _notificationsEnabled.value;
  String get unitSystem => _unitSystem.value;

  // Setters/Actions
  void toggleNotifications(bool value) {
    _notificationsEnabled.value = value;
    // Here you would typically save preference to local storage
  }

  void setUnitSystem(String value) {
    _unitSystem.value = value;
    // Here you would typically save preference to local storage
  }
}
