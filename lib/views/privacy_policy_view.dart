import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/colors.dart';
import '../res/styles.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Privacy Policy', style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Privacy Policy & Terms', style: AppStyles.dashboardTitle.copyWith(color: Theme.of(context).textTheme.titleLarge?.color)),
            const SizedBox(height: 20),
            Text(
              'Last Updated: March 2026',
              style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              '1. Introduction\n'
              'Welcome to the BMI Calculator app. We value your privacy and are committed to protecting your personal data. This privacy policy explains how we collect, use, and share information when you use our app.\n\n'
              '2. Data Collection\n'
              'We collect the information you provide directly to us, such as your age, gender, weight, height, and display name. We also collect your profile image if you choose to upload one.\n\n'
              '3. Use of Data\n'
              'The data collected is used solely to provide and improve the services of the App, specifically calculating your Body Mass Index (BMI), tracking your health goals, and providing personalized insights.\n\n'
              '4. Data Storage and Security\n'
              'We take reasonable measures to protect your information from unauthorized access, loss, misuse, or alteration. For user accounts authenticated via external services, we utilize secure authentication protocols.\n\n'
              '5. Local Storage\n'
              'Most of your personal metrics are stored locally on your device to ensure privacy and quick access.\n\n'
              '6. Changes to this Policy\n'
              'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.\n\n'
              '7. Contact Us\n'
              'If you have any questions about this Privacy Policy, please contact us at support@example.com.',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
