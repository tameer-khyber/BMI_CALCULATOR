import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final _storage = GetStorage();
  final _key = 'locale';

  @override
  void onInit() {
    super.onInit();
  }

  Locale? get initialLocale {
    final savedLocale = _storage.read(_key);
    if (savedLocale != null) {
      return Locale(savedLocale.split('_')[0], savedLocale.split('_')[1]);
    }
    // Default to system or English
    return Get.deviceLocale; 
  }

  void updateLocale(String languageCode, String countryCode) {
    final locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
    _storage.write(_key, '${languageCode}_$countryCode');
  }
}
