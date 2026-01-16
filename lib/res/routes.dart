import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/result_view.dart';
import '../views/history_view.dart'; 
import '../views/profile_view.dart';
import '../views/statistics_view.dart';
import '../views/health_insights_view.dart';
import '../views/settings_view.dart';
import '../views/splash_view.dart';
// ...

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/';
  static const String result = '/result';
  static const String history = '/history';
  static const String profile = '/profile';
  static const String statistics = '/statistics';
  static const String healthInsights = '/health-insights';
  static const String settings = '/settings'; // Added route // Added route

  static final pages = [
    GetPage(
      name: splash,
      page: () => const SplashView(), // Entry point
    ),
    GetPage(
      name: home,
      page: () => const HomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: result,
      page: () => ResultView(bmi: Get.arguments ?? 0.0), // Retrieve arg
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: history,
      page: () => const HistoryView(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: profile,
      page: () => const ProfileView(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: statistics,
      page: () => const StatisticsView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: healthInsights,
      page: () => const HealthInsightsView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: settings,
      page: () => const SettingsView(),
      transition: Transition.fadeIn,
    ),
  ];
}
