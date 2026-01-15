import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../res/styles.dart';

class HeightSlider extends StatelessWidget {
  final double height;
  final Function(double) onChanged;
  final bool isCm;
  final VoidCallback onToggleUnit;

  const HeightSlider({
    Key? key,
    required this.height,
    required this.onChanged,
    required this.isCm,
    required this.onToggleUnit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("HEIGHT", style: AppStyles.cardLabel),
              GestureDetector(
                onTap: onToggleUnit,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.textSecondary.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Text("cm", style: TextStyle(
                          color: isCm ? AppColors.textPrimary : AppColors.textSecondary.withOpacity(0.5),
                          fontWeight: FontWeight.bold)),
                      const Text(" / ", style: TextStyle(color: AppColors.textSecondary)),
                      Text("ft", style: TextStyle(
                          color: !isCm ? AppColors.textPrimary : AppColors.textSecondary.withOpacity(0.5),
                          fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                isCm ? height.toStringAsFixed(0) : (height / 30.48).toStringAsFixed(1),
                style: AppStyles.bigNumber,
              ),
              const SizedBox(width: 5),
              Text(isCm ? "cm" : "ft", style: AppStyles.unitLabel),
            ],
          ),
          Slider(
            value: height,
            min: 100,
            max: 250,
            onChanged: onChanged,
            activeColor: AppColors.red,
            inactiveColor: AppColors.textSecondary.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
