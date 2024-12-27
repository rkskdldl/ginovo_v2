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
    required this.gapDistanceTxt,
    required this.puttingDistanceTxt,
    required this.skidDistanceTxt,
    required this.launchAngleTxt,
  });
  final List<vec.Vector2> points;
  final List<vec.Vector2> skidPoints;
  final StartPoint startPoint;
  final EndPoint endPoint;
  final bool isTransPoints;
  final String gapDistanceTxt;
  final String puttingDistanceTxt;
  final String skidDistanceTxt;
  final String launchAngleTxt;
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
          widget.points.first.x>widget.points.last.x?Captions():Spacer(),
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
          widget.points.first.x>widget.points.last.x?Spacer():Captions(),
        ],
      ),
    );
  }

  Widget Captions(){
    return Expanded(
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
                  Text("Sides Distance",
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
