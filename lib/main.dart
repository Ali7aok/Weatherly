import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/pages/home_page.dart';
import 'package:weatherly/themes.dart/theme.dart';

void main() {
  runApp(MyApp());
}

class NoiseOverlay extends StatelessWidget {
  final double opacity;
  const NoiseOverlay({super.key, this.opacity = 0.05});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: NoisePainter(opacity),
    );
  }
}

class NoisePainter extends CustomPainter {
  final double opacity;
  NoisePainter(this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(opacity);
    final random = Random();

    for (int i = 0; i < 3000; i++) {
      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height;
      canvas.drawRect(Rect.fromLTWH(dx, dy, 1, 1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class FloatingBlurredShape extends StatelessWidget {
  final Widget child;
  
  const FloatingBlurredShape({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    
    final screenSize = MediaQuery.of(context).size;
    
    return Stack(
      children: [
        // White background
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
        ),
        
        // Ultra soft blurred shape - no sharp edges
        Positioned(
          left: screenSize.width * 0.5, // Slightly to the right
          top: screenSize.height * 0.25,
          child: Container(
            width: screenSize.width * 0.5, // Half page width
            height: screenSize.height * 0.5, // Half page height
            decoration: BoxDecoration(
              boxShadow: [
                // Massive blur layers for ultra soft edges
                BoxShadow(
                  color: Color(0xFF87CEEB).withOpacity(0.4),
                  blurRadius: 120,
                  spreadRadius: 40,
                ),
                BoxShadow(
                  color: Color(0xFF4682B4).withOpacity(0.3),
                  blurRadius: 150,
                  spreadRadius: 30,
                ),
                BoxShadow(
                  color: Color(0xFF6B73FF).withOpacity(0.2),
                  blurRadius: 180,
                  spreadRadius: 20,
                ),
                BoxShadow(
                  color: Color(0xFF87CEEB).withOpacity(0.15),
                  blurRadius: 200,
                  spreadRadius: 50,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // No visible gradient - only blur shadows create the effect
                color: Colors.transparent,
              ),
              child: Stack(
                children: [
                  // Noise grains inside the shape
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: NoiseOverlay(opacity: 0.02),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Your homepage content on top
        child,
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      home: FloatingBlurredShape(
        child: HomePage(),
      ),
    );
  }
}