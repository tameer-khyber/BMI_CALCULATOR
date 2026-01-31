import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../view_models/auth_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.registerFormKey,
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
                const SizedBox(height: 10),
                
                // Header
                Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color ?? AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign up to track your health journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Inputs
                CustomTextField(
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  controller: controller.nameController,
                  validator: controller.validateName,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                 CustomTextField(
                  label: 'Email',
                  icon: Icons.email_outlined,
                  controller: controller.emailController,
                  validator: controller.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Password',
                  icon: Icons.lock_outline,
                  controller: controller.passwordController,
                  isPassword: true,
                  validator: controller.validatePassword,
                  textInputAction: TextInputAction.next,
                ),
                 const SizedBox(height: 20),
                CustomTextField(
                  label: 'Confirm Password',
                  icon: Icons.verified_user_outlined,
                  controller: controller.confirmPasswordController,
                  isPassword: true,
                  validator: controller.validateConfirmPassword,
                  textInputAction: TextInputAction.done,
                ),
                
                const SizedBox(height: 40),
                
                // Register Button
                Obx(() => PrimaryButton(
                  label: 'REGISTER',
                  onPressed: controller.register,
                  isLoading: controller.isLoading.value,
                )),
                
                const SizedBox(height: 30),
                
                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(), // Goes back to Login
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
