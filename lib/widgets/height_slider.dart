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
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkBlue.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("HEIGHT", style: AppStyles.cardLabel),
              GestureDetector(
                onTap: onToggleUnit,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.lightBlue.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Text("cm", style: TextStyle(
                          color: isCm ? AppColors.darkBlue : AppColors.textSecondary.withValues(alpha: 0.5),
                          fontWeight: FontWeight.bold, fontSize: 14)),
                      const Text(" / ", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      Text("ft", style: TextStyle(
                          color: !isCm ? AppColors.darkBlue : AppColors.textSecondary.withValues(alpha: 0.5),
                          fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                isCm ? height.toStringAsFixed(0) : (height / 30.48).toStringAsFixed(1),
                style: AppStyles.bigNumber,
              ),
              const SizedBox(width: 8),
              Text(isCm ? "cm" : "ft", style: AppStyles.unitLabel),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(double.infinity, 50),
                  painter: RulerPainter(),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 2,
                    activeTrackColor: Colors.transparent, 
                    inactiveTrackColor: Colors.transparent,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 18.0, elevation: 5),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
                    thumbColor: AppColors.red,
                    overlayColor: AppColors.red.withValues(alpha: 0.15),
                  ),
                  child: Slider(
                    value: height,
                    min: 100,
                    max: 250,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RulerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.textSecondary.withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final double width = size.width;
    final double midY = size.height / 2;
    const int divisions = 40;
    final double step = width / divisions;

    for (int i = 0; i <= divisions; i++) {
        double x = i * step;
        double h = (i % 5 == 0) ? 15.0 : 8.0; 
        canvas.drawLine(
          Offset(x, midY - h/2),
          Offset(x, midY + h/2),
          paint,
        );
    }
    
    // Draw center line
    final Paint centerPaint = Paint()
      ..color = AppColors.textSecondary.withValues(alpha: 0.1)
      ..strokeWidth = 1;
      
    canvas.drawLine(
      Offset(0, midY), 
      Offset(width, midY), 
      centerPaint
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
