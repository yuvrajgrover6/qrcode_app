import 'dart:ui';

import 'package:flutter/material.dart';

class ScanOverlay extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // final Rect rect = Offset.zero & size;
    final Rect centreRect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: 200,
        height: 200);
    final Rect fullRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawPath(
        Path.combine(PathOperation.difference, Path()..addRect(fullRect),
            Path()..addRect(centreRect)),
        Paint()..color = Colors.black.withOpacity(0.6));
    canvas.drawRect(
        centreRect,
        Paint()
          ..color = Colors.green
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
