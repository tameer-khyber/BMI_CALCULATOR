import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../widgets/custom_bottom_nav.dart';
import '../res/routes.dart';

class HealthInsightsView extends StatelessWidget {
  const HealthInsightsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Health Insights", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                          const SizedBox(height: 4),
                          Text("Explore categories", style: AppStyles.welcomeText),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
                          ],
                        ),
                        child: const Icon(Icons.nightlight_round, color: AppColors.primary, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: AppColors.textSecondary),
                        hintText: "Search categories...",
                        hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Categories Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.85,
                    children: [
                      _buildCategoryCard(
                        "Nutrition Tips", 
                        "12 Articles", 
                        Icons.restaurant_menu_rounded, 
                        const Color(0xFFE0F2F1), // Light Teal
                        AppColors.primary
                      ),
                      _buildCategoryCard(
                        "Workout Plans", 
                        "8 Routine", 
                        Icons.fitness_center_rounded, 
                        const Color(0xFFFFEBEE), // Light Pink
                        AppColors.secondaryDark
                      ),
                      _buildCategoryCard(
                        "Sleep Tracking", 
                        "Daily Log", 
                        Icons.nights_stay_rounded, 
                        const Color(0xFFE8EAF6), // Light Indigo
                        const Color(0xFF3949AB)
                      ),
                      _buildCategoryCard(
                        "Water Intake", 
                        "2.5L Target", 
                        Icons.water_drop_rounded, 
                        const Color(0xFFE0F7FA), // Light Cyan
                        const Color(0xFF00ACC1)
                      ),
                      _buildCategoryCard(
                        "Mindfulness", 
                        "5 Sessions", 
                        Icons.self_improvement_rounded, 
                        const Color(0xFFFCE4EC), // Light Pink/Purple
                        const Color(0xFFE91E63) 
                      ),
                      _buildCategoryCard(
                        "Heart Health", 
                        "72 BPM Avg", 
                        Icons.favorite_rounded, 
                        const Color(0xFFEFF3F4), // Light Blue Grey
                        const Color(0xFF455A64)
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Daily Challenge
                  const Text("Daily Challenge", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Morning Cardio", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("15 mins high intensity interval training", style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text("Start Now", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Nav
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNav(
                selectedIndex: 2, // Insights Index
                onTap: (index) {
                   if (index == 0) Get.offNamed(AppRoutes.home);
                   if (index == 1) Get.offNamed(AppRoutes.statistics);
                   if (index == 3) Get.offNamed(AppRoutes.history);
                   if (index == 4) Get.offNamed(AppRoutes.profile);
                   if (index == 5) Get.offNamed(AppRoutes.settings);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, String subtitle, IconData icon, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const Spacer(),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
