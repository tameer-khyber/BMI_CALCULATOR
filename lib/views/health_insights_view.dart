import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../widgets/custom_bottom_nav.dart';
import '../res/routes.dart';
import 'insight_detail_view.dart'; // Import detailed view

import '../view_models/health_insights_controller.dart';

class HealthInsightsView extends StatelessWidget {
  const HealthInsightsView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HealthInsightsController());
    
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
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
                          Text('insights'.tr, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color)),
                          const SizedBox(height: 4),
                          Text('explore_categories'.tr, style: AppStyles.welcomeText),
                        ],
                      ),

                    ],
                  ),
                  const SizedBox(height: 25),

                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Get.theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                      child: TextField(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.search, color: AppColors.textSecondary),
                          hintText: 'search_placeholder'.tr,
                          hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Categories Grid
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: controller.insights.length,
                      itemBuilder: (context, index) {
                        final item = controller.insights[index];
                        return _buildCategoryCard(
                          item.title,
                          item.subtitle,
                          item.icon,
                          item.bgColor,
                          item.iconColor,
                          description: item.description,
                          imagePath: item.imagePath, 
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 30),

                  // Daily Challenge
                  Text('daily_challenge'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                  const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        height: 200,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8)),
                          ],
                          image: const DecorationImage(
                            image: AssetImage("assets/images/healthy_lifestyle.png"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                             Text('morning_cardio'.tr, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                             const SizedBox(height: 8),
                             Text('hiit_desc'.tr, style: const TextStyle(color: Colors.white, fontSize: 14)),
                             const SizedBox(height: 20),
                             ElevatedButton(
                              onPressed: () => Get.to(() => InsightDetailView(
                                title: 'morning_cardio'.tr, 
                                subtitle: 'hiit_desc'.tr, 
                                imagePath: "assets/images/healthy_lifestyle.png"
                              )),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              child: Text('start_now'.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _buildCategoryCard(
    String title, 
    String subtitle, 
    IconData icon, 
    Color bgColor, 
    Color iconColor, {
    String? imagePath,
    String? description,
  }) {
    return GestureDetector(
      onTap: () {
        if (imagePath != null) {
          Get.to(() => InsightDetailView(
            title: title, 
            subtitle: subtitle, 
            imagePath: imagePath,
            content: description ?? "Discover more about $title with our comprehensive guide.",
          ));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: imagePath != null ? Colors.black : bgColor, // Fallback color if no image
          borderRadius: BorderRadius.circular(24),
          image: imagePath != null 
            ? DecorationImage(
                image: imagePath.startsWith('http') 
                  ? NetworkImage(imagePath) as ImageProvider
                  : AssetImage(imagePath),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.4), BlendMode.darken),
              ) 
            : null,
          boxShadow: [
             BoxShadow(color: (imagePath != null ? Colors.black : bgColor).withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: imagePath != null ? Colors.white.withValues(alpha: 0.2) : Get.theme.cardColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: imagePath != null ? Colors.white : iconColor, size: 24),
            ),
            const Spacer(),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: imagePath != null ? Colors.white : AppColors.textPrimary)),
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(fontSize: 12, color: imagePath != null ? Colors.white.withValues(alpha: 0.8) : AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
