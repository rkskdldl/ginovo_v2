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


class PartialLineWidget extends StatefulWidget {
  const PartialLineWidget({super.key,required this.size,required this.lineLength, required this.gapLength});
  final Size size;
  final double lineLength; // 전체 선의 길이
  final double gapLength; // 중심 기준 제외할 길이
  @override
  State<PartialLineWidget> createState() => _PartialLineWidgetState();
}

class _PartialLineWidgetState extends State<PartialLineWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: widget.size, // 전체 캔버스 크기
        painter: PartialLinePainter(
          lineLength: widget.lineLength, // 선 전체 길이
          gapLength: widget.gapLength, // 중심을 기준으로 표시하지 않을 길이
        ),
      ),
    );
  }
}


class PartialLinePainter extends CustomPainter {
  final double lineLength; // 전체 선의 길이
  final double gapLength; // 중심 기준 제외할 길이

  PartialLinePainter({required this.lineLength, required this.gapLength});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff939393)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // 중심 좌표 계산
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // 선의 시작과 끝 위치 계산
    final startY = centerY - (lineLength / 2); // 상단 끝점
    final endY = centerY + (lineLength / 2); // 하단 끝점

    final gapStart = centerY - (gapLength / 2); // 제외 시작점
    final gapEnd = centerY + (gapLength / 2); // 제외 끝점

    // 선을 나눠서 그리기
    // 1. 중심 위쪽 선
    canvas.drawLine(
      Offset(centerX, startY),
      Offset(centerX, gapStart),
      paint,
    );

    // 2. 중심 아래쪽 선
    canvas.drawLine(
      Offset(centerX, gapEnd),
      Offset(centerX, endY),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AnglePainterWidget extends StatefulWidget {
  const AnglePainterWidget({super.key,
  required this.size,
    required this.center,
    required this.point1,
    required this.point2,
    required this.radiusFactor,
  });
  final Size size;
  final vec.Vector2 center;
  final vec.Vector2 point1;
  final vec.Vector2 point2;
  final double radiusFactor; // 반지름의 비율 (0.0 ~ 1.0)

  @override
  State<AnglePainterWidget> createState() => _AnglePainterWidgetState();
}

class _AnglePainterWidgetState extends State<AnglePainterWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size:widget.size, // 캔버스 크기
      painter: AnglePainter(
        center: widget.center, // 중심 좌표
        point1: widget.point1,  // 첫 번째 직선 끝점
        point2: widget.point2, // 두 번째 직선 끝점
        radiusFactor: widget.radiusFactor,
      ),
    );
  }
}


class AnglePainter extends CustomPainter {
  final vec.Vector2 center; // 중심점
  final vec.Vector2 point1; // 첫 번째 직선 끝점
  final vec.Vector2 point2; // 두 번째 직선 끝점
  final double radiusFactor; // 반지름의 비율 (0.0 ~ 1.0)
  AnglePainter({
    required this.center,
    required this.point1,
    required this.point2,
    required this.radiusFactor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintFill = Paint()
      ..color = Colors.greenAccent.withOpacity(0.5) // 영역 색상
      ..style = PaintingStyle.fill;

    // final paintLine = Paint()
    //   ..color = Colors.black
    //   ..strokeWidth = 2;

    // 반지름 비율을 적용한 새 끝점 계산
    vec.Vector2 scaledPoint1 = _scalePoint(center, point1, radiusFactor);
    vec.Vector2 scaledPoint2 = _scalePoint(center, point2, radiusFactor);

// 각도 경로 설정
    final path = Path()
      ..moveTo(center.x, center.y) // 중심점에서 시작
      ..lineTo(scaledPoint1.x, scaledPoint1.y) // 첫 번째 직선 끝점
      ..arcToPoint(
       Offset(scaledPoint2.x,scaledPoint2.y ),
        radius: Radius.circular(100), // 라운드 처리 반지름
        clockwise: true,
      ) // 원호 그리기
      ..close(); // 중심점으로 돌아감

    // 영역 색칠
    canvas.drawPath(path, paintFill);

    // // 직선 그리기
    // canvas.drawLine(center, point1, paintLine);
    // canvas.drawLine(center, point2, paintLine);
  }
  // 비율을 적용한 좌표 계산 함수
  vec.Vector2 _scalePoint(vec.Vector2 center, vec.Vector2 point, double factor) {
    return vec.Vector2(
      center.x + (point.x - center.x) * factor,
      center.y + (point.y - center.y) * factor,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}