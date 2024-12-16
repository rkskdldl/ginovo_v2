import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/helper/long_put_calculator.dart';
import 'package:ginovo_result/presentation/widgets/growing_dashed_line.dart';
import 'package:vector_math/vector_math_64.dart' as vec;

import '../../helper/mat_calculator.dart';

class LongPutPanel extends StatefulWidget {
  const LongPutPanel({super.key,required this.points,required this.skidPoints});
  final List<vec.Vector2> points;
  final List<vec.Vector2> skidPoints;
  @override
  State<LongPutPanel> createState() => _LongPutPanelState();
}

class _LongPutPanelState extends State<LongPutPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Row(
        children: [
          const Spacer(),
          Stack(
            children: [
              SizedBox(
                  width: 132.w,
                  height: MatCalculator.convertHeight.w,
                  child: Column(
                    children: [
                      Image.asset('assets/image/long_put_rail.png',height: 44.w,),
                      Expanded(
                        child: Container(
                          color: Color(0xffEEEEEE),
                          width: 2.w,
                        ),
                      )
                    ],
                  )
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: LongPutCalculator.convertHeight.w,
                    child: CustomPaint(
                      size: Size(132.w,LongPutCalculator.convertHeight.w), // 캔버스 크기
                      painter: LinePainter(
                          point1: Offset(widget.points.first.x, widget.points.first.y),
                          point2: Offset(widget.points.last.x,widget.points.last.y),
                          color: Color(0xffEEEEEE))
                    ),
                  ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child : SizedBox(
                    width: 132.w,
                    height:LongPutCalculator.convertHeight.w,
                    child: SmoothGrowingDashedLine(points: widget.points,color: Colors.green,)),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child : SizedBox(
                    width: 132.w,
                    height:LongPutCalculator.convertHeight.w,
                    child: SmoothGrowingDashedLine(points: widget.skidPoints,color: Colors.red,isShowArrow: false,duration: Duration(seconds: 2),)),
              ),
            ],
          ),
          Expanded(
              child: Container(
                height: MatCalculator.convertHeight.w,
                padding: EdgeInsets.only(left: 16.w),
                child: Stack(
                  children: [
                    Container(),
                    Positioned(
                      top:widget.points.last.y,
                      left: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("이격거리",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xff7A7A7A),
                            ),
                          ),
                          Text("0.02m",
                            style: TextStyle(
                                fontSize: 24.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top:(widget.points.first.y+widget.points.last.y)/2,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("이동거리",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xff7A7A7A),
                            ),
                          ),
                          Text("3.1m",
                            style: TextStyle(
                                fontSize: 24.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 50.w,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("스키드 거리",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xff7A7A7A),
                            ),
                          ),
                          Text("0.2m",
                            style: TextStyle(
                                fontSize: 24.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("이격각",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xff7A7A7A),
                            ),
                          ),
                          Text("3.0°",
                            style: TextStyle(
                                fontSize: 24.sp,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Offset point1; // 첫 번째 점
  final Offset point2; // 두 번째 점
  final Color color; // 선 색상
  final double strokeWidth; // 선 두께

  LinePainter({
    required this.point1,
    required this.point2,
    required this.color,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // 두 점 사이에 직선 그리기
    canvas.drawLine(point1, point2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
