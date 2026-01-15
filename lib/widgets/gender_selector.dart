import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../view_models/home_controller.dart';

class GenderSelector extends StatelessWidget {
  final Gender selectedGender;
  final Function(Gender) onSelect;

  const GenderSelector({
    Key? key,
    required this.selectedGender,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildGenderBtn(Gender.male, Icons.male, "MALE"),
          _buildGenderBtn(Gender.female, Icons.female, "FEMALE"),
        ],
      ),
    );
  }

  Widget _buildGenderBtn(Gender gender, IconData icon, String label) {
    final isSelected = selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelect(gender),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.selected : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 40,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
