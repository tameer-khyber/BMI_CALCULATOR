import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/colors.dart';

class InsightModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final String? imagePath;
  final String? description;

  InsightModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    this.imagePath,
    this.description,
  });
}

class HealthInsightsController extends GetxController {
  final RxList<InsightModel> insights = <InsightModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isOnline = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadInsights();
  }

  Future<void> loadInsights() async {
    isLoading.value = true;
    try {
      // Check connectivity
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline.value = true;
        await _fetchOnlineData();
      } else {
        isOnline.value = false;
        _loadOfflineData();
      }
    } on SocketException catch (_) {
      isOnline.value = false;
      _loadOfflineData();
    } catch (e) {
      // Fallback
      isOnline.value = false;
      _loadOfflineData();
    } finally {
      isLoading.value = false;
    }
  }

  void _loadOfflineData() {
    // 9+ Offline Topics
    insights.value = [
      InsightModel(
        title: 'Nutrition Basics',
        subtitle: 'Eat well, live well',
        icon: Icons.restaurant_menu_rounded,
        bgColor: const Color(0xFFE0F2F1),
        iconColor: AppColors.primary,
        description: 'Understand the building blocks of a healthy diet: measure macros, stay hydrated, and eat whole foods.',
      ),
      InsightModel(
        title: 'Home Workouts',
        subtitle: 'No equipment needed',
        icon: Icons.fitness_center_rounded,
        bgColor: const Color(0xFFFFEBEE),
        iconColor: AppColors.secondaryDark,
        description: 'Effective bodyweight exercises you can do in your living room. Pushups, squats, and lunges.',
      ),
      InsightModel(
        title: 'Sleep Hygiene',
        subtitle: 'Better rest',
        icon: Icons.nights_stay_rounded,
        bgColor: const Color(0xFFE8EAF6),
        iconColor: const Color(0xFF3949AB),
        description: 'Create a sleep schedule, reduce blue light exposure, and optimize your bedroom for deep sleep.',
      ),
      InsightModel(
        title: 'Hydration 101',
        subtitle: 'Drink more water',
        icon: Icons.water_drop_rounded,
        bgColor: const Color(0xFFE0F7FA),
        iconColor: const Color(0xFF00ACC1),
        description: 'Water is essential for energy. Learn how much you really need.',
      ),
      InsightModel(
        title: 'Mindfulness',
        subtitle: 'Stress reduction',
        icon: Icons.self_improvement_rounded,
        bgColor: const Color(0xFFFCE4EC),
        iconColor: const Color(0xFFE91E63),
        description: 'Simple breathing exercises to calm your mind in 5 minutes.',
      ),
      InsightModel(
        title: 'Cardio Health',
        subtitle: 'Heart strong',
        icon: Icons.favorite_rounded,
        bgColor: const Color(0xFFEFF3F4),
        iconColor: const Color(0xFF455A64),
        description: 'Benefits of walking, running, and swimming for your heart.',
      ),
       InsightModel(
        title: 'Stretching',
        subtitle: 'Flexibility',
        icon: Icons.accessibility_new_rounded,
        bgColor: const Color(0xFFF3E5F5),
        iconColor: Colors.purple,
        description: 'Daily stretches to prevent injury and improve posture.',
      ),
       InsightModel(
        title: 'Immune Boost',
        subtitle: 'Stay healthy',
        icon: Icons.medication_rounded,
        bgColor: const Color(0xFFE8F5E9),
        iconColor: Colors.green,
        description: 'Foods rich in Vitamin C and Zinc to support your immune system.',
      ),
       InsightModel(
        title: 'Mental Focus',
        subtitle: 'Productivity',
        icon: Icons.psychology_rounded,
        bgColor: const Color(0xFFFFF8E1),
        iconColor: Colors.amber,
        description: 'Techniques to improve concentration and reduce brain fog.',
      ),
    ];
  }

  Future<void> _fetchOnlineData() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simulated Online Data - normally this would come from an API
    insights.value = [
      InsightModel(
        title: 'Latest Superfoods',
        subtitle: 'Trending Now',
        icon: Icons.eco_rounded,
        bgColor: Colors.green.shade50,
        iconColor: Colors.green,
        description: 'Discover the top 5 superfoods of 2026: Algae, Moringa, and more.',
      ),
      InsightModel(
        title: 'Marathon Training',
        subtitle: 'Expert Guide',
        icon: Icons.directions_run_rounded,
        bgColor: Colors.orange.shade50,
        iconColor: Colors.deepOrange,
        description: 'A 12-week plan to get you ready for your first marathon.',
      ),
      InsightModel(
        title: 'Recovery Tech',
        subtitle: 'New Gadgets',
        icon: Icons.battery_charging_full_rounded,
        bgColor: Colors.blue.shade50,
        iconColor: Colors.blue,
        description: 'Reviewing the best massage guns and compression boots.',
      ),
      InsightModel(
        title: 'Plant-Based Diet',
        subtitle: 'Go Green',
        icon: Icons.grass_rounded,
        bgColor: Colors.lime.shade50,
        iconColor: Colors.lime,
        description: 'How to transition to a plant-based diet without losing muscle.',
      ),
      InsightModel(
        title: 'Yoga for Back Pain',
        subtitle: 'Relief',
        icon: Icons.spa_rounded,
        bgColor: Colors.purple.shade50,
        iconColor: Colors.purple,
        description: '5 essential poses to soothe your aching back.',
      ),
       InsightModel(
        title: 'Intermittent Fasting',
        subtitle: 'Science',
        icon: Icons.timer_rounded,
        bgColor: Colors.teal.shade50,
        iconColor: Colors.teal,
        description: 'Does it really work? Breaking down the pros and cons.',
      ),
       InsightModel(
        title: 'Healthy Snacks',
        subtitle: 'On the Go',
        icon: Icons.lunch_dining_rounded,
        bgColor: Colors.brown.shade50,
        iconColor: Colors.brown,
        description: 'Low-calorie snacks that keep you full and energized.',
      ),
       InsightModel(
        title: 'Hydration Hacks',
        subtitle: 'Drink Up',
        icon: Icons.local_drink_rounded,
        bgColor: Colors.lightBlue.shade50,
        iconColor: Colors.lightBlue,
        description: 'Creative ways to drink more water every day.',
      ),
       InsightModel(
        title: 'Sleep Science',
        subtitle: 'Deep Dive',
        icon: Icons.bedtime_rounded,
        bgColor: Colors.indigo.shade50,
        iconColor: Colors.indigo,
        description: 'Understanding REM cycles and how to optimize them.',
      ),
    ];
  }
}
