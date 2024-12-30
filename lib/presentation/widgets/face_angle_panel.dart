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
                  childWidget:LayoutBuilder(builder: (ctx,constraints){
                    return Container(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              HighLightTxtWidget(width:200.w, height: 180.w,angle:widget.mostTopAngle,percent: widget.mostTopPercent,),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    child: AngleGradientVisualization(
                                        width: 130.w,height: 120.w,
                                        angles:widget.topAngles),
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Center(child: SemiCircleAngleWidget(width: 100.w, height: 100.w))),

                            ],
                          ),
                          Image.asset('assets/image/putter_top_single.png',width: 16.w,),
                        ],
                      ),
                    );
                  }) ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: PanelContainer(
                  customPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.w),
                  childWidget:Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset('assets/image/putter_side_single.png',width: 16.w,),
                        SizedBox(width: 10.w,),
                        Stack(
                          children: [
                            QuaterHighLightTxtWidget(width:100.w, height: 200.w,angle: widget.mostSideAngle,percent: widget.mostSidePercent,),
                            Positioned(
                              bottom: 0,
                              child: QuaterAngleGradientVisualization(
                                  width: 68.w,height: 68.w,
                                  angles: widget.sideAngles),
                            ),
                            Positioned(
                                bottom: 0,
                                child: QuaterCircleAngleWidget(width: 50.w, height: 50.w)),
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
