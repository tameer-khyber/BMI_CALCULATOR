import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/routes.dart';
import '../res/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observables
  final isLoading = false.obs;
  
  // Form Keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
  
  late Rx<User?> firebaseUser;
  // Flag to handle initial auth check separately (let SplashView handle it)
  bool _isInitialAuthCheck = true;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _handleAuthChanged);
  }

  void _handleAuthChanged(User? user) {
    // If it's the first check, let the SplashView handle the navigation logic after its animation/delay.
    // This prevents the auth listener from immediately redirecting before Splash is shown.
    if (_isInitialAuthCheck) {
      _isInitialAuthCheck = false;
      return;
    }

    if (user == null) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.offAllNamed(AppRoutes.home);
    }
  }

  // Validation Logic
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(value)) return 'Invalid email format';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 chars';
    return null;
  }

  String? validateName(String? value) {
     if (value == null || value.isEmpty) return 'Name is required';
     return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirm Password is required';
    if (value != passwordController.text) return 'Passwords do not match';
    return null;
  }

  // Actions
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;
    
    // Hide keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    isLoading.value = true;
    
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Navigation is now handled by _handleAuthChanged
      
      Get.snackbar(
        "Success", 
        "Welcome back!", 
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: AppColors.success, 
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
        borderRadius: 20
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred";
      
      print("Firebase Auth Error: ${e.code} - ${e.message}");

      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found with this email.";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is badly formatted.";
          break;
        case 'invalid-credential':
          errorMessage = "Invalid email or password.";
          break;
        case 'user-disabled':
          errorMessage = "This user has been disabled.";
          break;
        default:
          errorMessage = e.message ?? "Authentication failed";
      }

      Get.snackbar(
        "Login Failed", 
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
        borderRadius: 20
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;
    
    // Hide keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    isLoading.value = true;
    
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      
      // Update display name
      await userCredential.user?.updateDisplayName(nameController.text.trim());
      
      // Navigation is now handled by _handleAuthChanged

      Get.snackbar(
        "Success", 
        "Account created successfully!", 
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: AppColors.success, 
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
        borderRadius: 20
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Registration failed";
      
      print("Firebase Auth Error: ${e.code} - ${e.message}");

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = "The email is already in use.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is invalid.";
          break;
        case 'weak-password':
          errorMessage = "The password is too weak.";
          break;
        default:
          errorMessage = e.message ?? "Registration failed";
      }

      Get.snackbar(
        "Registration Failed", 
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        margin: const EdgeInsets.all(20), 
        borderRadius: 20
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    clearInputs(); 
    // Navigation is now handled by _handleAuthChanged
  }
  
  void clearInputs() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    confirmPasswordController.clear();
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter your email");
      return;
    }
    
    isLoading.value = true;
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      Get.back(); // Go back to login
      Get.snackbar(
        "Success", 
        "Password reset link sent to $email",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success, 
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
        borderRadius: 20
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error", 
        e.message ?? "Failed to send reset email",
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: AppColors.error, 
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
        borderRadius: 20
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  void goToRegister() {
    Get.toNamed('/register'); 
  }
  
  void goToLogin() {
    Get.back();
  }
}
