import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vector_math/vector_math_64.dart' as vec;

class SmoothGrowingDashedLine extends StatefulWidget {
  final List<vec.Vector2> points;
  final double dashLength;
  final double gapLength;
  final Duration duration;
  final Color color;
  final bool isShowArrow;
  const SmoothGrowingDashedLine({
    Key? key,
    required this.points,
    this.dashLength = 5.0,
    this.gapLength = 3.0,
    this.duration = const Duration(seconds: 4),
    required this.color,
    this.isShowArrow = true,
  }) : super(key: key);

  @override
  _SmoothGrowingDashedLineState createState() =>
      _SmoothGrowingDashedLineState();
}

class _SmoothGrowingDashedLineState extends State<SmoothGrowingDashedLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: SmoothDashedLineWithArrowPainter(
            points: widget.points,
            dashLength: widget.dashLength,
            gapLength: widget.gapLength,
            animationValue: _controller.value,
            color: widget.color,
            isShowArrow: widget.isShowArrow,
          ),
        );
      },
    );
  }
}

class SmoothDashedLineWithArrowPainter extends CustomPainter {
  final List<vec.Vector2> points;
  final double dashLength;
  final double gapLength;
  final double animationValue;
  final Color color;
  final bool isShowArrow;
  SmoothDashedLineWithArrowPainter({
    required this.points,
    required this.dashLength,
    required this.gapLength,
    required this.animationValue,
    required this.color,
    required this.isShowArrow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(points[0].x, points[0].y);

    // Create a smooth curve using quadraticBezierTo
    for (int i = 0; i < points.length - 1; i++) {
      final midPointX = (points[i].x + points[i + 1].x) / 2;
      final midPointY = (points[i].y + points[i + 1].y) / 2;
      // path.quadraticBezierTo(
      //   points[i].x,
      //   points[i].y,
      //   midPointX,
      //   midPointY,
      // );
      path.cubicTo(
        points[i].x,
        points[i].y,
        midPointX,
        midPointY,
        points[i + 1].x,
        points[i + 1].y,
      );

    }

    // Convert Path to Dashed Path based on animation progress
    final dashedPath = _createDashedPath(path, animationValue);
    canvas.drawPath(dashedPath, paint);

    if(isShowArrow){
    // Draw Arrow at the End
    if (points.isNotEmpty) {
      final metric = path.computeMetrics().last;
      final tangent = metric.getTangentForOffset(metric.length * animationValue);
      if (tangent != null) {
          _drawArrow(canvas, paint, tangent.position, tangent.vector);
        }
      }
    }
  }

  Path _createDashedPath(Path path, double progress) {
    final dashedPath = Path();
    final pathMetrics = path.computeMetrics();

    for (final metric in pathMetrics) {
      final length = metric.length * progress;
      double distance = 0.0;

      while (distance < length) {
        final dashEnd = distance + dashLength;
        dashedPath.addPath(
          metric.extractPath(distance, dashEnd.clamp(0, length)),
          Offset.zero,
        );
        distance += dashLength + gapLength;
      }
    }

    return dashedPath;
  }

  void _drawArrow(Canvas canvas, Paint paint, Offset position, Offset direction) {
    const arrowSize = 8.0;
    final angle = direction.direction;

    final arrowPath = Path();
    arrowPath.moveTo(position.dx, position.dy);
    arrowPath.lineTo(
      position.dx - arrowSize * cos(angle - pi / 6),
      position.dy - arrowSize * sin(angle - pi / 6),
    );
    arrowPath.moveTo(position.dx, position.dy);
    arrowPath.lineTo(
      position.dx - arrowSize * cos(angle + pi / 6),
      position.dy - arrowSize * sin(angle + pi / 6),
    );

    canvas.drawPath(arrowPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}