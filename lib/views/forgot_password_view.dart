import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../view_models/auth_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controller is likely already in memory, but safe to find
    // final controller = Get.find<AuthController>(); 
    // GetView gives us `controller` property.

    // We might need a separate TextEditingController for this view 
    // or reuse emailController if appropriate. 
    // To be clean, let's use a local controller for this field or 
    // rely on the AuthController's emailController if the user came from Login
    // and typed something.
    
    // However, resetting the password usually requires just the email. 
    // Let's use the one in AuthController for simplicity, assuming 
    // user might have typed it in Login.

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: AppColors.textSecondary),
                  onPressed: () => Get.back(),
                ),
              ),
              const SizedBox(height: 20),
              
              Text(
                'Forgot Password',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Enter your email address and we will send you a link to reset your password.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              
              CustomTextField(
                label: 'Email',
                icon: Icons.email_outlined,
                controller: controller.emailController,
                validator: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              
              const SizedBox(height: 40),
              
              Obx(() => PrimaryButton(
                label: 'SEND RESET LINK',
                onPressed: () => controller.resetPassword(controller.emailController.text),
                isLoading: controller.isLoading.value,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
