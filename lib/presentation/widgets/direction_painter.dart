import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mat;
import 'package:vector_math/vector_math_64.dart';

class DirectionPainter extends CustomPainter {
  final Vector3 direction;

  DirectionPainter(this.direction);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = mat.Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    // 화면의 가운데에 방향 벡터를 그립니다.
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2),
      Offset(size.width / 2 + direction.x * 100, size.height / 2 - direction.z * 100),
      paint, // z축을 위로 표시
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

