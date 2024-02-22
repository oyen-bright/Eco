import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;

  const DashedDivider(
      {super.key,
      this.height = 1,
      this.color = Colors.black,
      this.dashWidth = 10.0});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(
          height: height, color: color, dashWidth: dashWidth),
      size: Size(double.infinity, height),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double height;
  final Color color;
  final double dashWidth;

  _DashedLinePainter(
      {required this.height, required this.color, required this.dashWidth});

  @override
  void paint(Canvas canvas, Size size) {
    double dashSpace = 5.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
