import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/presentation/widgets/putter_panel.dart';
import 'package:ginovo_result/presentation/widgets/web_3d_viewer.dart';

import 'dashed_line.dart';
import 'hitted_dot.dart';

class RotationSection extends StatefulWidget {
  const RotationSection({super.key,required this.spinAngle,required this.spinRPM,required this.hitPoint,required this.spinType});
  final double spinAngle;
  final int spinRPM;
  final Offset hitPoint;
  final SpinType spinType;
  @override
  State<RotationSection> createState() => _RotationSectionState();
}

class _RotationSectionState extends State<RotationSection> {
  Timer? _timer;
  bool isShowHitPoint = true;
  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 10*1000), (timer){
      setState(() {
        isShowHitPoint = !isShowHitPoint;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    _timer?.cancel(); // 타이머 해제
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 40.w,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Spin",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 24.sp,
              ),
            ),
          ),
          SizedBox(height: 20.w,),
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
              width: double.maxFinite,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${widget.spinRPM}",
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text("RPM",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xff898989),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width:240.w,
                        height:240.w,
                        child: Container(child: Web3dViewer(spinAngle:widget.spinAngle,spinType: widget.spinType,)),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child:DashedLineWidget(
                            length: 160.w,
                            direction: Axis.vertical,
                            color: Color(0xff959595),
                            dashLength: 1,
                            dashSpacing: 1,
                          )
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child:DashedLineWidget(
                            length: 160.w,
                            direction: Axis.horizontal,
                            color: Color(0xff959595),
                            dashLength: 1,
                            dashSpacing: 1,
                          )
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child:Transform.rotate(
                            angle: widget.spinAngle * pi /180,
                            child: PartialLineWidget(
                                size: const Size.fromWidth(double.maxFinite),
                                lineLength: 240.w,
                                gapLength: 140.w),
                          )
                      ),
                      Positioned(
                        top: 20.w,
                        bottom:  20.w,
                        left:  20.w,
                        right:  20.w,
                        child: SizedBox(
                            child: DashedArcWidget(
                                size:Size(160.w, 160.w),
                                dashLength: 2,
                                gapLength: 2,
                                strokeWidth: 2,
                                color: Color(0xff959595),
                                startAngle: ((widget.spinAngle<0?270+widget.spinAngle:270) *pi/180),
                                sweepAngle: (widget.spinAngle.abs() *pi/180))
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom:  0,
                        left:  0,
                        right:  0,
                        child: Container(
                            child: Align(
                                alignment: widget.spinAngle>0?widget.spinAngle.abs()<=90?Alignment.topRight:Alignment.bottomRight:widget.spinAngle.abs()<=90?Alignment.topLeft:Alignment.bottomLeft,
                                child: Text("${widget.spinAngle>0?"R":widget.spinAngle<0?"L":""} ${widget.spinAngle.abs().toStringAsFixed(1)}°",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  ),
                                ))
                        ),
                      ),
                      Center(
                          child: Transform.translate(
                              offset: Offset(widget.hitPoint.dx * (70.w/100), widget.hitPoint.dy * -1* (70.w/100)),
                              child: isShowHitPoint?HittedDot():Container())),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
