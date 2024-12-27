import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
List<List<Color>> colorSets = [
  [Colors.lightGreenAccent.withOpacity(0.8), Colors.greenAccent, Colors.lightGreenAccent.withOpacity(0.8)],
  [Colors.yellowAccent.withOpacity(0.8),Colors.yellow,Colors.yellowAccent.withOpacity(0.8)],
  [Colors.orangeAccent.withOpacity(0.8),Colors.orange,Colors.orangeAccent.withOpacity(0.8)],
  [Colors.redAccent.withOpacity(0.8),Colors.red, Colors.redAccent.withOpacity(0.8)],
];

class AngleGradientVisualization extends StatelessWidget {
  final List<double> angles;
  final double width;
  final double height;
  const AngleGradientVisualization({Key? key,
    required this.angles,
    required this.width,
    required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, (height/2)),
      painter: RingHeatmapPainter(angles: angles),
    );
  }
}

class QuaterAngleGradientVisualization extends StatelessWidget {
  final List<double> angles;
  final double width;
  final double height;
  const QuaterAngleGradientVisualization({Key? key,
    required this.angles,
    required this.width,
    required this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, (height/2)),
      painter: QuaterRingHeatmapPainter(angles: angles),
    );
  }
}


class RingHeatmapPainter extends CustomPainter {
  final List<double> angles;

  RingHeatmapPainter({required this.angles});

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 6; // 띠 두께
    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.width / 2 - strokeWidth / 2,
    );

    // 각도 빈도 계산
    final Map<int, int> angleCounts = {};
    for (final angle in angles) {
      double compositeAngle = angle<0? 360+angle:angle;
      final normalizedAngle = (compositeAngle % 360).toInt(); // 0~359로 변환
      angleCounts[normalizedAngle] = (angleCounts[normalizedAngle] ?? 0) + 1;
    }
    // 1. Map의 내용을 List로 변환
    List<MapEntry<int, int>> entryList = angleCounts.entries.toList();

    // 2. List를 값(value)을 기준으로 정렬
    entryList.sort((a, b) => a.value.compareTo(b.value));

    // 3. 정렬된 List를 다시 Map으로 변환
    Map<int, int> sortedMap = Map.fromEntries(entryList);



    for (int key in sortedMap.keys) {
      int counter = sortedMap[key]!;

      int convertedKey = key>=270?key-360:key;

      // 그라데이션 정의
      Gradient gradient = SweepGradient(
        startAngle: (270+ convertedKey) * pi / 180,
        endAngle: (270+convertedKey +2) * pi / 180,
        colors: counter==1?colorSets[0]:counter==2?colorSets[1]:counter==3?colorSets[2]:colorSets[3],
        stops:[0.0,0.5,1],
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
        (270+convertedKey) * pi / 180, // 시작 각도
        4* pi / 180, // 전체 원 (360도)
        false,
        paint,
      );
    }
    }

 @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 데이터 변경 시 다시 그리기
  }
}

class QuaterRingHeatmapPainter extends CustomPainter {
  final List<double> angles;

  QuaterRingHeatmapPainter({required this.angles});

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 6; // 띠 두께
    final Rect rect = Rect.fromCircle(
      center: Offset(0, size.height),
      radius: size.width - strokeWidth / 2,
    );

    // 각도 빈도 계산
    final Map<int, int> angleCounts = {};
    for (final angle in angles) {
      double compositeAngle = angle<0? 360+angle:angle;
      final normalizedAngle = (compositeAngle % 360).toInt(); // 0~359로 변환
      angleCounts[normalizedAngle] = (angleCounts[normalizedAngle] ?? 0) + 1;
    }
    // 1. Map의 내용을 List로 변환
    List<MapEntry<int, int>> entryList = angleCounts.entries.toList();

    // 2. List를 값(value)을 기준으로 정렬
    entryList.sort((a, b) => a.value.compareTo(b.value));

    // 3. 정렬된 List를 다시 Map으로 변환
    Map<int, int> sortedMap = Map.fromEntries(entryList);



    for (int key in sortedMap.keys) {
      int counter = sortedMap[key]!;

      int convertedKey =key;

      // 그라데이션 정의
      Gradient gradient = SweepGradient(
        startAngle: (360-convertedKey) * pi / 180,
        endAngle: (360-convertedKey +2) * pi / 180,
        colors: counter==1?colorSets[0]:counter==2?colorSets[1]:counter==3?colorSets[2]:colorSets[3],
        stops:[0.0,0.5,1],
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
        (360-convertedKey) * pi / 180, // 시작 각도
        4* pi / 180, // 전체 원 (360도)
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 데이터 변경 시 다시 그리기
  }
}


class SemiCircleAngleWidget extends StatelessWidget {

  const SemiCircleAngleWidget({super.key,required this.width,required this.height});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height:  (height/2).w,
      child: CustomPaint(
        size: Size(width.w, (height/2).w), // 반구의 크기 (너비와 높이)
        painter: SemiCirclePainter(),
      ),
    );
  }
}

class SemiCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final double radius = size.width / 2; // 반구의 반지름
    final Offset center = Offset(size.width / 2, size.height); // 반구의 중심 (하단 중앙)

    // 반구 그리기
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius-10.w),
      pi, // 시작 각도 (-90도)
      pi, // 180도 (반구)
      false,
      paint,
    );

    final Paint paint2 = Paint()
      ..color = Color(0xffD0D0D0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    //라인 그리기
    canvas.drawLine(Offset(center.dx-radius+10.w, center.dy), Offset(center.dx+radius-10.w, center.dy), paint2);

    final Paint paint3 = Paint()
      ..color = Color(0xffD0D0D0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // 점선의 간격과 길이 설정
    const double dashWidth = 2; // 점선의 길이
    const double gapWidth = 2;  // 점선 사이의 간격

    final double startX = center.dx; // 시작 X 좌표
    final double startY = center.dy-(radius-14.w); // 시작 Y 좌표
    final double endY = center.dy; // 끝 Y 좌표

    double currentY = startY;

    // 점선을 그리는 반복문
    while (currentY < endY) {
      final double nextY = currentY + dashWidth;
      if (nextY > endY) {
        // 마지막 선이 끝점을 넘지 않도록 조정
        canvas.drawLine(Offset(startX, currentY), Offset(startX, endY), paint3);
      } else {
          canvas.drawLine(
              Offset(startX, currentY), Offset(startX, nextY), paint3);
      }
      currentY = nextY + gapWidth; // 점선 + 간격 만큼 이동
    }
    // final txtPainter = TextPainter(
    //   text: TextSpan(
    //     text: '퍼터페이스 각도',
    //     style: TextStyle(fontSize: 10.sp, color: Color(0xffB3B4B8)),
    //   ),
    //   textDirection: TextDirection.ltr,
    // );
    // txtPainter.layout();
    //
    // final Offset adjustedPosition = Offset(startX, (startY+endY)/2).translate(
    //   -txtPainter.width / 2,
    //   -txtPainter.height / 2,
    // ); // 텍스트 위치를 조정
    // txtPainter.paint(canvas, adjustedPosition);


    // 각도 텍스트 표시
    for (int angle = -90; angle <= 90; angle += 30) {
      final double radian = ((270+angle) * pi) / 180; // 각도를 라디안으로 변환
      final Offset textPosition = Offset(
        center.dx + radius * cos(radian),
        center.dy + radius * sin(radian),
      );

      // 각도 텍스트 그리기
      final textPainter = TextPainter(
        text: TextSpan(
          text: '$angle°',
          style: TextStyle(fontSize: 10.sp, color: Colors.black),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final Offset adjustedPosition = textPosition.translate(
        -textPainter.width / 2,
        -textPainter.height / 2,
      ); // 텍스트 위치를 조정
      textPainter.paint(canvas, adjustedPosition);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
class HighLightTxtWidget extends StatelessWidget {

  const HighLightTxtWidget({
    super.key,
    required this.width,
    required this.height,
    required this.angle,
    required this.percent,
  });
  final double width;
  final double height;
  final double angle;
  final double percent;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height:  (height/2).w,
      child: CustomPaint(
        size: Size(width.w, (height/2).w), // 반구의 크기 (너비와 높이)
        painter: HighLightTxtPainter(
            angle:angle,
            percent: percent),
      ),
    );
  }
}

class HighLightTxtPainter extends CustomPainter {
  HighLightTxtPainter({required this.angle,required this.percent});
  final double angle;
  final double percent;
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final double radius = size.height; // 반구의 반지름
    final Offset center = Offset(size.width / 2, size.height); // 반구의 중심 (하단 중앙)
    // 각도 텍스트 표시
      final double radian = ((270+angle) * pi) / 180; // 각도를 라디안으로 변환
      final Offset textPosition = Offset(
        center.dx + radius * cos(radian),
        center.dy + radius * sin(radian),
      );

      // 각도 텍스트 그리기
      final textPainter = TextPainter(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${percent.toStringAsFixed(0)}%\n',
              style: TextStyle(fontSize: 11.sp, color: Color(0xffA6A6A6),fontWeight: FontWeight.w500,  ),
            ),
            TextSpan(
              text: '${angle>0?"R":angle<0?"L":""} ${angle.abs()}°',
              style: TextStyle(fontSize: 11.sp, color: Color(0xff000000),fontWeight: FontWeight.w500  ),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
      );
      textPainter.layout();

      final Offset adjustedPosition = textPosition.translate(
        -textPainter.width / 2,
        -textPainter.height / 2,
      ); // 텍스트 위치를 조정
      textPainter.paint(canvas, adjustedPosition);
    }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class QuaterCircleAngleWidget extends StatelessWidget {

  const QuaterCircleAngleWidget({super.key,required this.width,required this.height});
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height:  (height/2).w,
      child: CustomPaint(
        size: Size(width.w, (height/2).w), // 반구의 크기 (너비와 높이)
        painter: QuaterCirclePainter(),
      ),
    );
  }
}

class QuaterCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final double radius = size.width; // 반구의 반지름
    final Offset center = Offset(0, size.height); // 반구의 중심 (하단 중앙)

    // 반구 그리기
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius-10.w),
      270 * pi / 180, // 시작 각도 (-90도)
      pi/2, // 180도 (반구)
      false,
      paint,
    );

    final Paint paint2 = Paint()
      ..color = Color(0xffD0D0D0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    //라인 그리기
    canvas.drawLine(Offset(center.dx, center.dy), Offset(center.dx+radius-10.w, center.dy), paint2);

    final Paint paint3 = Paint()
      ..color = Color(0xffD0D0D0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // 점선의 간격과 길이 설정
    const double dashWidth = 2; // 점선의 길이
    const double gapWidth = 2;  // 점선 사이의 간격

    final double startX = center.dx; // 시작 X 좌표
    final double startY = center.dy-(radius-14.w); // 시작 Y 좌표
    final double endY = center.dy; // 끝 Y 좌표

    double currentY = startY;

    // 점선을 그리는 반복문
    while (currentY < endY) {
      final double nextY = currentY + dashWidth;
      if (nextY > endY) {
        // 마지막 선이 끝점을 넘지 않도록 조정
        canvas.drawLine(Offset(startX, currentY), Offset(startX, endY), paint3);
      } else {
        canvas.drawLine(
            Offset(startX, currentY), Offset(startX, nextY), paint3);
      }
      currentY = nextY + gapWidth; // 점선 + 간격 만큼 이동
    }
    // final txtPainter = TextPainter(
    //   text: TextSpan(
    //     text: '퍼터페이스 각도',
    //     style: TextStyle(fontSize: 10.sp, color: Color(0xffB3B4B8)),
    //   ),
    //   textDirection: TextDirection.ltr,
    // );
    // txtPainter.layout();
    //
    // final Offset adjustedPosition = Offset(startX, (startY+endY)/2).translate(
    //   -txtPainter.width / 2,
    //   -txtPainter.height / 2,
    // ); // 텍스트 위치를 조정
    // txtPainter.paint(canvas, adjustedPosition);


    // 각도 텍스트 표시
    for (int angle =0; angle <= 90; angle += 30) {
      final double radian = ((270+angle) * pi) / 180; // 각도를 라디안으로 변환
      final Offset textPosition = Offset(
        center.dx + radius * cos(radian),
        center.dy + radius * sin(radian),
      );

      // 각도 텍스트 그리기
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${90 - angle}°',
          style: TextStyle(fontSize: 10.sp, color: Colors.black),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final Offset adjustedPosition = textPosition.translate(
        -textPainter.width / 2,
        -textPainter.height / 2,
      ); // 텍스트 위치를 조정
      textPainter.paint(canvas, adjustedPosition);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class QuaterHighLightTxtWidget extends StatelessWidget {

  const QuaterHighLightTxtWidget({
    super.key,
    required this.width,
    required this.height,
    required this.angle,
    required this.percent,
  });
  final double width;
  final double height;
  final double angle;
  final double percent;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height:  (height/2).w,
      child: CustomPaint(
        size: Size(width.w, (height/2).w), // 반구의 크기 (너비와 높이)
        painter: QuaterHighLightTxtPainter(
            angle:angle,
            percent: percent),
      ),
    );
  }
}

class QuaterHighLightTxtPainter extends CustomPainter {
  QuaterHighLightTxtPainter({required this.angle,required this.percent});
  final double angle;
  final double percent;
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final double radius = size.height; // 반구의 반지름
    final Offset center = Offset(0, size.height); // 반구의 중심 (하단 중앙)
    // 각도 텍스트 표시
    final double radian = ((360-angle) * pi) / 180; // 각도를 라디안으로 변환
    final Offset textPosition = Offset(
      center.dx + radius * cos(radian),
      center.dy + radius * sin(radian),
    );

    // 각도 텍스트 그리기
    final textPainter = TextPainter(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${percent.toStringAsFixed(0)}%\n',
              style: TextStyle(fontSize: 11.sp, color: Color(0xffA6A6A6),fontWeight: FontWeight.w500,  ),
            ),
            TextSpan(
              text: '${angle.abs()}°',
              style: TextStyle(fontSize: 11.sp, color: Color(0xff000000),fontWeight: FontWeight.w500  ),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center
    );
    textPainter.layout();

    final Offset adjustedPosition = textPosition.translate(
      -textPainter.width / 2,
      -textPainter.height / 2,
    ); // 텍스트 위치를 조정
    textPainter.paint(canvas, adjustedPosition);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class HittingHighLightWidget extends StatelessWidget {

  const HittingHighLightWidget({super.key,required this.width,required this.height,required this.angle,required this.percent,required this.redOffset});
  final double width;
  final double height;
  final double angle;
  final double percent;
  final Offset redOffset;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomPaint(
        size: Size(width, (height)), // 반구의 크기 (너비와 높이)
        painter: HittingHighLightPainter(angle: angle,percent: percent,redOffset: redOffset),
      ),
    );
  }
}

class HittingHighLightPainter extends CustomPainter {
  final double angle;
  final double percent;
  final Offset redOffset;
  HittingHighLightPainter({required this.angle,required this.percent,required this.redOffset});

  @override
  void paint(Canvas canvas, Size size) {

    final double radius = size.width / 2 -6.w; // 반구의 반지름
    final Offset center = Offset(size.width / 2,size.height); // 반구의 중심 (하단 중앙)

    final Paint paint = Paint()
      ..color = Color(0xffa5a5a5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    //라인 그리기

    final double radian = ((270+angle) * pi) / 180; // 각도를 라디안으로 변환
    final Offset endPosition = Offset(
      center.dx + radius * cos(radian),
        (center.dy-55.w) + radius * sin(radian),
    );

    canvas.drawLine(Offset(center.dx, center.dy-55.w),endPosition, paint);


    // 각도 텍스트 그리기
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${percent.toStringAsFixed(0)}%',
        style: TextStyle(fontSize: 11.sp, color: Colors.grey,fontWeight: FontWeight.w500),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    // left: centerX + offset.dx.w - 4.w, // 중심점 기준 Offset
    // top: centerY - offset.dy.w - 4.w,
    double ratio = 100/110;
    final textPosition = Offset(center.dx+(redOffset.dx*ratio),(center.dy-55.w)-(redOffset.dy*ratio)+14.w);

    final Offset adjustedPosition = textPosition.translate(
      -textPainter.width / 2,
      -textPainter.height / 2,
    ); // 텍스트 위치를 조정
    textPainter.paint(canvas, adjustedPosition);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
