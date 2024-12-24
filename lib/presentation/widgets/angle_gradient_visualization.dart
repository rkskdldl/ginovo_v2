import 'dart:math';

import 'package:flutter/material.dart';
class AngleGradientVisualization extends StatelessWidget {
  final List<double> angles;

  const AngleGradientVisualization({Key? key, required this.angles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300),
      painter: RingHeatmapPainter(angles: angles),
    );
  }
}

class RingHeatmapPainter extends CustomPainter {
  final List<double> angles;

  RingHeatmapPainter({required this.angles});

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 14; // 띠 두께
    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2 - strokeWidth / 2,
    );

    // 각도 빈도 계산
    final Map<int, int> angleCounts = {};
    for (final angle in angles) {
      final normalizedAngle = (angle % 360).toInt(); // 0~359로 변환
      angleCounts[normalizedAngle] = (angleCounts[normalizedAngle] ?? 0) + 1;
    }

    List<List<Color>> colorSets = [
      [Colors.white.withOpacity(0),Colors.lightGreenAccent, Colors.lightGreenAccent, Colors.lightGreenAccent,Colors.white.withOpacity(0)],
      [Colors.white.withOpacity(0),Colors.greenAccent,Colors.yellowAccent,Colors.greenAccent,Colors.white.withOpacity(0)],
      [Colors.white.withOpacity(0),Colors.yellowAccent,Colors.orangeAccent,Colors.yellowAccent,Colors.white.withOpacity(0)],
      [Colors.white.withOpacity(0),Colors.orangeAccent,Colors.red, Colors.orangeAccent,Colors.white.withOpacity(0)],
    ];

    for (int key in angleCounts.keys) {
      int counter = angleCounts[key]!;


      // 그라데이션 정의
      Gradient gradient = SweepGradient(
        startAngle: (270+ key) * pi / 180,
        endAngle: (270+key +10) * pi / 180,
        colors: counter==1?colorSets[0]:counter==2?colorSets[1]:counter==3?colorSets[2]:colorSets[3],
        stops:[0.0,0.3,0.5,0.7, 1],
      );

      // 페인트 설정
      Paint paint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt; // 끝부분 둥글게 처리

      // 원형 띠 그리기
      canvas.drawArc(
        rect,
        (270+key) * pi / 180, // 시작 각도
        10 * pi / 180, // 전체 원 (360도)
        false,
        paint,
      );
    }
    }

 @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // 데이터 변경 시 다시 그리기
  }
}