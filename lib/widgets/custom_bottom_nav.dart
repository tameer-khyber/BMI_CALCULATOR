import 'package:flutter/material.dart';
import '../res/colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    this.selectedIndex = 2, // Default to center (Add button)
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 70,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.grid_view_rounded, 0),
          _buildNavItem(Icons.bar_chart_rounded, 1),
          // _buildNavItem(Icons.widgets_rounded, 2), // Removed as per request
          _buildAddButton(),
          _buildNavItem(Icons.history_rounded, 3),
          // _buildNavItem(Icons.person_outline_rounded, 4), // Moved to Header
          _buildNavItem(Icons.settings_rounded, 5),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = selectedIndex == index;
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
        size: 28,
      ),
      onPressed: () => onTap(index),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () => onTap(99), // 99 is the special index for the add button action
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
