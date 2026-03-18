import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/colors.dart';
import '../res/decorations.dart';
import '../res/styles.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget primaryButton;
  final Widget? secondaryButton;

  const CustomBottomSheet({
    Key? key,
    required this.title,
    required this.content,
    required this.primaryButton,
    this.secondaryButton,
  }) : super(key: key);

  static void show({
    required String title,
    required Widget content,
    required Widget primaryButton,
    Widget? secondaryButton,
  }) {
    Get.bottomSheet(
      CustomBottomSheet(
        title: title,
        content: content,
        primaryButton: primaryButton,
        secondaryButton: secondaryButton,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine bottom padding for keyboard if it's open
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: AppDecorations.dashboardGlassDecoration(context),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white30 : Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Title
                  Text(
                    title,
                    style: AppStyles.dashboardTitle.copyWith(
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Custom Content
                  content,
                  const SizedBox(height: 32),
                  // Action Buttons
                  Row(
                    children: [
                      if (secondaryButton != null) ...[
                        Expanded(child: secondaryButton!),
                        const SizedBox(width: 16),
                      ],
                      Expanded(child: primaryButton),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
