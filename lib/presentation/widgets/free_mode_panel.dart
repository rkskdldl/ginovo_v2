import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/helper/free_calculator.dart';
import 'package:ginovo_result/helper/long_put_calculator.dart';
import 'package:ginovo_result/presentation/widgets/growing_dashed_line.dart';
import 'package:vector_math/vector_math_64.dart' as vec;

import '../../helper/mat_calculator.dart';
import 'dashed_line.dart';
import 'long_put_panel.dart';

class FreePanel extends StatefulWidget {
  const FreePanel({
    super.key,
    required this.points,
    required this.skidPoints,
    required this.gapDistanceTxt,
    required this.puttingDistanceTxt,
    required this.skidDistanceTxt,
    required this.launchAngleTxt
  });
  final List<vec.Vector2> points;
  final List<vec.Vector2> skidPoints;
  final String gapDistanceTxt;
  final String puttingDistanceTxt;
  final String skidDistanceTxt;
  final String launchAngleTxt;
  @override
  State<FreePanel> createState() => _FreePanelState();
}

class _FreePanelState extends State<FreePanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            widget.points.first.x>widget.points.last.x?Captions():Spacer(),
            Container(
              color: Color(0xfff3f3f3),
              padding: EdgeInsets.symmetric(vertical: 16.w),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          width: FreeCalculator.convertWidth.w,
                          height: FreeCalculator.convertHeight.w+44.w,
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
                        child : SizedBox(
                            width: FreeCalculator.convertWidth.w,
                            height: FreeCalculator.convertHeight.w,
                            child: AnglePainterWidget(
                                radiusFactor: 0.7,
                                size: Size(FreeCalculator.convertWidth.w, FreeCalculator.convertHeight.w),
                                center: widget.points.first,
                                point1: vec.Vector2( widget.points.first.x, widget.points.last.y),
                                point2: widget.points.last)),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: FreeCalculator.convertHeight.w,
                          child: CustomPaint(
                              size: Size(FreeCalculator.convertWidth.w,FreeCalculator.convertHeight.w), // 캔버스 크기
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
                            width: FreeCalculator.convertWidth.w,
                            height:FreeCalculator.convertHeight.w,
                            child: SmoothGrowingDashedLine(points: widget.points,color: Colors.greenAccent,)),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child : SizedBox(
                            width: FreeCalculator.convertWidth.w,
                            height:FreeCalculator.convertHeight.w,
                            child: SmoothGrowingDashedLine(points: widget.skidPoints,color: Colors.red,isShowArrow: false,duration: Duration(seconds: 2),)),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child : SizedBox(
                            width: FreeCalculator.convertWidth.w,
                            height:FreeCalculator.convertHeight.w,
                            child: SmoothGrowingDashedLine(
                              points: MatCalculator.instance.generateCurvePoints(startPoint: widget.points.first, endPoint: widget.points.last, isRight: widget.points.last.x<0),
                              color: Color(0xffDCDCDC),
                              isShowArrow: false,
                              dashLength: 2,
                              gapLength: 2,
                              strokeWidth: 1,
                              duration: Duration(seconds: 0),
                            )),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child : SizedBox(
                            width: FreeCalculator.convertWidth.w,
                            height:FreeCalculator.convertHeight.w,
                            child: SmoothGrowingDashedLine(
                              points: [widget.points.last,vec.Vector2(widget.points.first.x, widget.points.last.y)],
                              color: Color(0xffDCDCDC),
                              isShowArrow: false,
                              dashLength: 2,
                              gapLength: 2,
                              strokeWidth: 1,
                              duration: Duration(seconds: 0),
                            )),
                      ),
                    ],
                  ),
                  Container(
                      child: Image.asset("assets/image/ball_img.png",width: 16.w,)),
                ],
              ),
            ),
            widget.points.first.x>widget.points.last.x?Spacer():Captions(),

          ],
        ),
      ],
    );
  }

  Widget Captions(){
    return Expanded(
        child: Container(
          height: FreeCalculator.convertHeight.w+76.w,
          padding: EdgeInsets.only(left: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Separation\nDistance",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff7A7A7A),
                    ),
                  ),
                  Text("${widget.gapDistanceTxt}",
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Putt Distance",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff7A7A7A),
                    ),
                  ),
                  Text("${widget.puttingDistanceTxt}",
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Skid Distance",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff7A7A7A),
                    ),
                  ),
                  Text("${widget.skidDistanceTxt}",
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Launch Angle",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Color(0xff7A7A7A),
                    ),
                  ),
                  Text("${widget.launchAngleTxt}",
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}

