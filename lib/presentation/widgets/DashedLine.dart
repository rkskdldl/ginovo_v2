import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vec;

class DashedLine extends StatelessWidget {
  final vec.Vector2 startPoint;
  final vec.Vector2 endPoint;
  final double dashLength;
  final double gapLength;

  const DashedLine({
    Key? key,
    required this.startPoint,
    required this.endPoint,
    this.dashLength = 3.0,
    this.gapLength = 3.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: DashedLinePainter(
        startPoint: startPoint,
        endPoint: endPoint,
        dashLength: dashLength,
        gapLength: gapLength,
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final vec.Vector2 startPoint;
  final vec.Vector2 endPoint;
  final double dashLength;
  final double gapLength;

  DashedLinePainter({
    required this.startPoint,
    required this.endPoint,
    required this.dashLength,
    required this.gapLength,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff676767)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final start = Offset(startPoint.x, startPoint.y);
    final end = Offset(endPoint.x, endPoint.y);

    _drawDashedLine(canvas, paint, start, end);
  }

  void _drawDashedLine(Canvas canvas, Paint paint, Offset start, Offset end) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final distance = sqrt(dx * dx + dy * dy);
    final unitVector = Offset(dx / distance, dy / distance);

    double currentDistance = 0.0;

    while (currentDistance < distance) {
      // 점선의 시작점
      final dashStart = Offset(
        start.dx + unitVector.dx * currentDistance,
        start.dy + unitVector.dy * currentDistance,
      );

      // 점선의 끝점 계산
      final nextDashEndDistance = (currentDistance + dashLength).clamp(0, distance);
      final dashEnd = Offset(
        start.dx + unitVector.dx * nextDashEndDistance,
        start.dy + unitVector.dy * nextDashEndDistance,
      );

      // 점선 그리기
      canvas.drawLine(dashStart, dashEnd, paint);

      // 다음 점선 위치로 이동
      currentDistance += dashLength + gapLength;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
