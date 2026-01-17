import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class FadeInSlide extends StatelessWidget {
  final Widget child;
  final double delay;
  final Duration duration;
  final double slideOffset;

  const FadeInSlide({
    Key? key,
    required this.child,
    this.delay = 0,
    this.duration = const Duration(milliseconds: 800),
    this.slideOffset = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: (delay * 1000).toInt()),
      duration: duration,
      from: slideOffset,
      child: child,
    );
  }
}
