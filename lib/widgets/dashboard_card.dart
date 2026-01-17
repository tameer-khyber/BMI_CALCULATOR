import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../res/decorations.dart';

class DashboardCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const DashboardCard({
    super.key,
    required this.child,
    this.color,
    this.onTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: AppDecorations.dashboardCardDecoration(context, color: color),
        child: child,
      ),
    );
  }
}
