import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientSlider extends StatelessWidget {
  final double percentage;

  const GradientSlider({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(250.w, 17.h),
      painter: GradientSliderPainter(percentage),
    );
  }
}

class GradientSliderPainter extends CustomPainter {
  final double percentage;
  GradientSliderPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = 20.0; // Border radius of 20

    final Paint paintBackground = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint paintFill = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFFFFDA58), Color(0xFFFF924D)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width * percentage, size.height));

    // Draw the background with rounded corners (white)
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(radius)),
      paintBackground,
    );

    // Draw the filled part with rounded corners (gradient)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width * percentage, size.height),
        Radius.circular(radius),
      ),
      paintFill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}