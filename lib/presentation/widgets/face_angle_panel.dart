import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'angle_gradient_visualization.dart';
import 'data_panel.dart';

class FaceAnglePanel extends StatefulWidget {
  const FaceAnglePanel({super.key,
    required this.mostTopAngle,
    required this.mostTopPercent,
    required this.topAngles,
    required this.mostSideAngle,
    required this.mostSidePercent,
    required this.sideAngles,
  });
  final double mostTopAngle;
  final double mostTopPercent;
  final List<double> topAngles;
  final double mostSideAngle;
  final double mostSidePercent;
  final List<double> sideAngles;
  @override
  State<FaceAnglePanel> createState() => _FaceAnglePanelState();
}

class _FaceAnglePanelState extends State<FaceAnglePanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Face Angle",
            style: TextStyle(
              fontSize: 20.sp,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 20.w,),
        Row(
          children: [
            Expanded(
              child: PanelContainer(
                  customPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 20.w),
                  titleWidget: Padding(
                    padding: EdgeInsets.only(bottom:  10.w),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("TopView",style: TextStyle(
                        fontSize: 10.sp,
                        color: Color(0xffb9b9b9),
                      ),
                      ),
                    ),
                  ),
                  childWidget:LayoutBuilder(builder: (ctx,constraints){
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  HighLightTxtWidget(width:200.w, height: 180.w,angle:widget.mostTopAngle,percent: widget.mostTopPercent,bias: 6,),
                                  Container(height: 10.w,),
                                ],
                              ),
                              Positioned(
                                bottom: 10.w,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    child: AngleGradientVisualization(
                                        width: 130.w,height: 120.w,bias: 6,
                                        angles:widget.topAngles),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 10.w,
                                  child: Center(child: SemiCircleAngleWidget(width: 100.w, height: 100.w,startAngle: 210*pi/180, angleRange: 120*pi/180,))),

                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child:SizedBox(child:
                                  Transform.rotate(
                                    angle: (widget.mostTopAngle*6*pi/180),
                                      alignment: Alignment.topCenter,
                                      child: Image.asset('assets/image/putter_top_single.png',height: 10.w,)))
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }) ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: PanelContainer(
                  customPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.w),
                  titleWidget: Padding(
                    padding: EdgeInsets.only(bottom:  10.w),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("SideView",style: TextStyle(
                        fontSize: 10.sp,
                        color: Color(0xffb9b9b9),
                      ),),
                    ),
                  ),
                  childWidget:Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/image/putter_side_single.png',width: 16.w,),
                        SizedBox(width: 10.w,),
                        Stack(
                          children: [
                            QuaterHighLightTxtWidget(width:90.w, height: 100.w,angle: widget.mostSideAngle,percent: widget.mostSidePercent,bias: 6,),
                            Positioned(
                              bottom: 0,
                              child: QuaterAngleGradientVisualization(
                                  width: 70.w,height: 50.w,
                                  angles: widget.sideAngles,
                              bias:6,
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                child: QuaterCircleAngleWidget(width: 50.w, height: 50.w,startAngle: 300*pi/180,angleRange: 120*pi/180,bias: 6,)),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
