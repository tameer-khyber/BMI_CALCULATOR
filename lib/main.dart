import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'res/theme.dart';
import 'view_models/home_controller.dart';
import 'res/routes.dart';

void main() {
  runApp(const BmiApp());
}

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject Controller
    Get.put(HomeController());

    return GetMaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
    );
  }
}
