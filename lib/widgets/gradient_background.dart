import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const GradientBackground({
    Key? key, 
    required this.child, 
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: appBar,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF5F7FA), // Light cool grey
              Color(0xFFC3CFE2), // Softer metallic blue-grey
            ],
          ),
        ),
        child: SafeArea(child: child),
      ),
    );
  }
}
