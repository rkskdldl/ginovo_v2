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
            child: Text("클럽 페이스",
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
            child: Text("${widget.topAngle.toStringAsFixed(1)}°",
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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}