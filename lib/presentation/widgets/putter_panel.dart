import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum PutterViewType{
  TOP,
  SIDE
}


class PutterSection extends StatefulWidget {
  const PutterSection({super.key,required this.topAngle,required this.sideAngle});
  final double topAngle;
  final double sideAngle;
  @override
  State<PutterSection> createState() => _PutterSectionState();
}

class _PutterSectionState extends State<PutterSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 40.w,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Face Angle",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 24.sp,
              ),
            ),
          ),
          SizedBox(height: 20.w,),
          Row(
            children: [
              Expanded(child: PutterPanelTop(topAngle:widget.topAngle)),
              SizedBox(width: 12.w,),
              Expanded(child: PutterPanelSide(sideAngle:widget.sideAngle)),
            ],
          ),
          SizedBox(height:30.w),
        ],
      )
    );
  }
}



class PutterPanelTop extends StatefulWidget {
  const PutterPanelTop({super.key,required this.topAngle});
  final double topAngle;
  @override
  State<PutterPanelTop> createState() => _PutterPanelTopState();
}
class PutterPanelSide extends StatefulWidget {
  const PutterPanelSide({super.key,required this.sideAngle});
  final double sideAngle;
  @override
  State<PutterPanelSide> createState() => _PutterPanelSideState();
}
class _PutterPanelSideState extends State<PutterPanelSide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // 둥근 모서리
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // 그림자 색상 및 투명도
            spreadRadius: 2, // 그림자 크기 확장
            blurRadius: 4, // 그림자 흐림 정도
            offset: Offset(0, 4), // 그림자 위치 (x, y)
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text("SideView",
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xff7A7A7A),
              ),
            ),
          ),
          SizedBox(height: 4.w,),
          Align(
            alignment: Alignment.centerRight,
            child: Text("${widget.sideAngle.toStringAsFixed(1)}°",
              style: TextStyle(
                fontSize: 24.sp,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 8.w,),
          Stack(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                     SizedBox(width: 40.w,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DashedLineWidget(
                          length: 100.w,
                          direction: Axis.vertical,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    child: DashedLineWidget(
                      length: double.maxFinite,
                      direction: Axis.horizontal,
                    ),
                  ),
                  SizedBox(height: 30.w,),
                ],
              ),
              Positioned(
                  bottom: 30.w,
                  left: 24.w,
                  right: 0,
                  child: Transform.rotate(
                    origin: Offset(20.w, 0),
                    alignment: Alignment.bottomLeft,
                      angle: widget.sideAngle * -1 * pi / 180,
                      child: Image.asset('assets/image/putter_side.png',width: 100.w,))),
              Positioned(
                bottom: 31.w,
                left: 8.w,
                right: 72.w,
                child: SizedBox(
                  child: ArcPainterWidget(
                    viewType: PutterViewType.SIDE,
                    angle: widget.sideAngle,// 호(각도 단위)
                    radius:20, // 호의 반지름
                    strokeWidth: 2, // 호의 두께

                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class _PutterPanelTopState extends State<PutterPanelTop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // 둥근 모서리
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // 그림자 색상 및 투명도
            spreadRadius: 2, // 그림자 크기 확장
            blurRadius: 4, // 그림자 흐림 정도
            offset: Offset(0, 4), // 그림자 위치 (x, y)
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text("TopView",
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xff7A7A7A),
              ),
            ),
          ),
          SizedBox(height: 4.w,),
          Align(
            alignment: Alignment.centerRight,
            child: Text("${widget.topAngle>0?"R":widget.topAngle<0?"L":""} ${widget.topAngle.toStringAsFixed(1)}°",
              style: TextStyle(
                fontSize: 24.sp,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 8.w,),
          Stack(
            children: [
              Column(
                children: [
                  DashedLineWidget(
                    length: 100.w,
                    direction: Axis.vertical,
                  ),
                  DashedLineWidget(
                    length: 100.w,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(height: 30.w,),
                ],
              ),
              Positioned(
                  bottom: 30.w-13.w,
                  left: 0,
                  right: 0,
                  child: Transform.rotate(
                      angle: widget.topAngle * pi / 180,
                      child: Image.asset('assets/image/putter_top.png',width: 100.w,))),
              Positioned(
                bottom: 31.w,
                left: 40.w,
                right: 40.w,
                  child: SizedBox(
                    child: ArcPainterWidget(
                        angle: widget.topAngle,// 호의 길이 (각도 단위)
                      radius:20, // 호의 반지름
                      strokeWidth: 2, // 호의 두께
                    ),
                  ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashedLineWidget extends StatelessWidget {
  final double length;
  final Axis direction; // 점선 방향: 수직 또는 수평
  final Color color;
  final double dashLength;
  final double dashSpacing;

  const DashedLineWidget({
    Key? key,
    required this.length,
    this.direction = Axis.vertical,
    this.color = const Color(0xff676767),
    this.dashLength = 1,
    this.dashSpacing = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: direction == Axis.horizontal ? length : 2,
      height: direction == Axis.vertical ? length : 2,
      child: CustomPaint(
        painter: _DashedLinePainter(
          direction: direction,
          color: color,
          dashLength: dashLength,
          dashSpacing: dashSpacing,
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Axis direction;
  final Color color;
  final double dashLength;
  final double dashSpacing;

  _DashedLinePainter({
    required this.direction,
    required this.color,
    required this.dashLength,
    required this.dashSpacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    if (direction == Axis.vertical) {
      double startY = 0;
      while (startY < size.height) {
        canvas.drawLine(
          Offset(size.width / 2, startY),
          Offset(size.width / 2, startY + dashLength),
          paint,
        );
        startY += dashLength + dashSpacing;
      }
    } else {
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset(startX + dashLength, size.height / 2),
          paint,
        );
        startX += dashLength + dashSpacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ArcPainterWidget extends StatelessWidget {
  final double angle; // 호의 길이 (각도)
  final Color color; // 호의 색상
  final double radius; // 호의 반지름
  final double strokeWidth; // 호의 두께
  final PutterViewType viewType;

   const ArcPainterWidget({
    Key? key,
    this.angle=0,
    this.color = const Color(0xffFF3535),
    this.radius = 100,
    this.strokeWidth = 1,
    this.viewType = PutterViewType.TOP,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(radius * 2, radius * 2),
      painter: ArcPainter(
        radius: radius,
        angle:angle,
        color: color,
        strokeWidth: strokeWidth,
        viewType: viewType,
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double angle; // 호의 길이 (각도)
  final Color color; // 호의 색상
  final double strokeWidth; // 호의 두께
  final double radius;
  final PutterViewType  viewType;
  ArcPainter({
    required this.angle,
    required this.color,
    required this.strokeWidth,
    required this.radius,
    required this.viewType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;


    double startAngle = 0;
    double lengthAngle = angle.abs();
    if(viewType == PutterViewType.TOP){
      if(angle<0){
        startAngle = 180 + angle;
      }
    }else if(viewType ==PutterViewType.SIDE){
      startAngle  = 360 - angle;

    }


    final radians = startAngle * pi / 180;
    final radians2 = lengthAngle * pi / 180;

    // 원의 중심
    final center = Offset(size.width / 2, size.height);

    // 호 그리기
    canvas.drawArc(
      Rect.fromCircle(center:center, radius: radius), // 호의 외곽 원
     radians, // 시작 각도
      radians2, // sweep 각도
      false, // 호 내부 채우기 여부 (false = 채우지 않음)
      paint, // 페인트 스타일
    );

    final double radian = radians+(radians2/2); // 각도를 라디안으로 변환
    final Offset textPosition = Offset(
      center.dx + (radius*2) * cos(radian),
      center.dy + (radius*2) * sin(radian),
    );

    // 각도 텍스트 그리기
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${angle}°',
        style: TextStyle(fontSize: 10.sp, color: Colors.black, fontWeight: FontWeight.w500),
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DashedArcWidget extends StatefulWidget {
  const DashedArcWidget({
    super.key,
    required this.size,
    required this.dashLength,
    required this.gapLength,
    required this.strokeWidth,
    required this.color,
    required this.startAngle,
    required this.sweepAngle,
  });
  final Size size;
  final double dashLength; // 점선 길이
  final double gapLength; // 점선 간격
  final double strokeWidth; // 선 두께
  final Color color; // 선 색상
  final double startAngle; // 시작 각도 (라디안)
  final double sweepAngle; // 호의 전체 각도 (라디안)
  @override
  State<DashedArcWidget> createState() => _DashedArcWidgetState();
}

class _DashedArcWidgetState extends State<DashedArcWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size, // 캔버스 크기
      painter: DashedArcPainter(
        dashLength: widget.dashLength, // 점선의 길이
        gapLength: widget.gapLength, // 점선 간격
        strokeWidth: widget.strokeWidth, // 선의 두께
        color: widget.color, // 선 색상
        startAngle: widget.startAngle, // 시작 각도 (라디안)
        sweepAngle: widget.sweepAngle, // 호의 각도 (90도 = pi/2 라디안)
      ),
    );
  }
}


class DashedArcPainter extends CustomPainter {
  final double dashLength; // 점선 길이
  final double gapLength; // 점선 간격
  final double strokeWidth; // 선 두께
  final Color color; // 선 색상
  final double startAngle; // 시작 각도 (라디안)
  final double sweepAngle; // 호의 전체 각도 (라디안)

  DashedArcPainter({
    required this.dashLength,
    required this.gapLength,
    required this.strokeWidth,
    required this.color,
    required this.startAngle,
    required this.sweepAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2); // 중심점
    final radius = min(size.width, size.height) / 2 - strokeWidth; // 반지름

    // 점선 그리기
    double currentAngle = startAngle; // 현재 그릴 각도
    final totalCircumference = sweepAngle * radius; // 호의 총 길이
    final totalDashes = totalCircumference / (dashLength + gapLength); // 총 점선 수

    for (int i = 0; i < totalDashes; i++) {
      // 시작 각도와 끝 각도 계산
      final startDashAngle = currentAngle;
      final endDashAngle = currentAngle + (dashLength / radius);

      // 점선의 시작점과 끝점 계산
      final startPoint = Offset(
        center.dx + radius * cos(startDashAngle),
        center.dy + radius * sin(startDashAngle),
      );
      final endPoint = Offset(
        center.dx + radius * cos(endDashAngle),
        center.dy + radius * sin(endDashAngle),
      );

      // 작은 점선을 그리기
      canvas.drawLine(startPoint, endPoint, paint);

      // 다음 점선의 시작 각도로 이동
      currentAngle = endDashAngle + (gapLength / radius);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}