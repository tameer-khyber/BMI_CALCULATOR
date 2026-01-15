import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../res/styles.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.red, // Using Red for CTA as it's a strong action color in the palette
        borderRadius: BorderRadius.circular(15), 
        boxShadow: [
          BoxShadow(
            color: AppColors.red.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Center(
            child: Text(
              label,
              style: AppStyles.buttonText,
            ),
          ),
        ),
      ),
    );
  }
}
