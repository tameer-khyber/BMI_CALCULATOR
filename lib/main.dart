import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'res/theme.dart';
import 'view_models/home_controller.dart';
import 'view_models/history_controller.dart';
import 'res/routes.dart';
import 'res/messages.dart';
import 'view_models/language_controller.dart';
import 'view_models/auth_controller.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Lock orientation to portrait mode only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  await GetStorage.init();
  runApp(const BmiApp());
}

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject Controllers
    Get.put(HistoryController());
    Get.put(HomeController());
    Get.put(AuthController());
    final languageController = Get.put(LanguageController());

    return GetMaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      translations: Messages(), // Your translations
      locale: languageController.initialLocale ?? const Locale('en', 'US'), // Default locale
      fallbackLocale: const Locale('en', 'US'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light, // Default to light mode as requested
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
    );
  }
}
