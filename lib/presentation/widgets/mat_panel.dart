import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vector_math/vector_math_64.dart' as vec;

import '../../helper/mat_calculator.dart';
import 'dashed_line.dart';
import 'growing_dashed_line.dart';
class MatPanel extends StatefulWidget {
  const MatPanel({super.key,
    required this.points,
    required this.skidPoints,
    required this.startPoint,
    required this.endPoint,
    required this.isTransPoints,
  });
  final List<vec.Vector2> points;
  final List<vec.Vector2> skidPoints;
  final StartPoint startPoint;
  final EndPoint endPoint;
  final bool isTransPoints;
  @override
  State<MatPanel> createState() => _MatPanelState();
}

class _MatPanelState extends State<MatPanel> {

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
                  child: Image.asset("assets/image/mat_90_grey.png")
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child : SizedBox(
                    width: 132.w,
                    height:MatCalculator.convertHeight.w,
                    child: AnglePainterWidget(
                        radiusFactor: 0.7,
                        size: Size(double.maxFinite, double.maxFinite),
                        center: MatCalculator.instance.getStartPoint(sp: widget.startPoint),
                        point1: widget.points.last,
                        point2: MatCalculator.instance.getEndPoint(ep: widget.endPoint))),
              ),
              Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  width: 132.w,
                  height: MatCalculator.convertHeight.w,
                  child: DashedLine(
                      startPoint:MatCalculator.instance.getStartPoint(sp:widget.startPoint),
                      endPoint: MatCalculator.instance.getEndPoint(ep:widget.endPoint)),
                ),
              ),
              widget.isTransPoints?Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child : SizedBox(
                    width: 132.w,
                    height: MatCalculator.convertHeight.w,
                    child: SmoothGrowingDashedLine(points: widget.points,color: Colors.greenAccent,)),
              ):Container(),
              widget.isTransPoints?Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child : SizedBox(
                    width: 132.w,
                    height: MatCalculator.convertHeight.w,
                    child: SmoothGrowingDashedLine(points: widget.skidPoints,color: Colors.red,isShowArrow: false,duration: Duration(seconds: 2),)),
              ):Container(),
              Transform.translate(
                offset: Offset(MatCalculator.instance.getStartPoint(sp: widget.startPoint).x-8.w,MatCalculator.instance.getStartPoint(sp: widget.startPoint).y-8.w),
                child: Container(
                    child: Image.asset("assets/image/ball_img.png",width: 16.w,)),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child : SizedBox(
                    width: 132.w,
                    height:MatCalculator.convertHeight.w,
                    child: SmoothGrowingDashedLine(
                      points: [widget.points.last,vec.Vector2(MatCalculator.instance.getEndPoint(ep: widget.endPoint).x, widget.points.last.y)],
                      color: Color(0xff676767),
                      isShowArrow: false,
                      dashLength: 2,
                      gapLength: 2,
                      strokeWidth: 1,
                      duration: Duration(seconds: 0),
                    )),
              ),
            ],
          ),
          Expanded(
              child: Container(
                height: MatCalculator.convertHeight.w,
                padding: EdgeInsets.only(left: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                    Column(
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
                    Column(
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
                    Column(
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
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
