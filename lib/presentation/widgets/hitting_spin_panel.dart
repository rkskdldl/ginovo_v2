import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'angle_gradient_visualization.dart';
import 'data_panel.dart';
import 'heat_map_indicator.dart';

class HittingSpinPanel extends StatefulWidget {
  const HittingSpinPanel({super.key,
    required this.hittingPoints,
    required this.angles,
    required this.mostAngle,
    required this.mostAnglePercent,
    required this.mostHittingPoint,
    required this.mostHittingPercent,
  });
  final List<Offset> hittingPoints;
  final List<double> angles;
  final double mostAngle;
  final double mostAnglePercent;
  final Offset mostHittingPoint;
  final double mostHittingPercent;

  @override
  State<HittingSpinPanel> createState() => _HittingSpinPanelState();
}

class _HittingSpinPanelState extends State<HittingSpinPanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Hitting Point & Spin",
            style: TextStyle(
              fontSize: 20.sp,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 20.w,),
        PanelContainer(
            childWidget:Container(
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            width: 240.w,
                            height:160.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                        width:110.w,
                                        height: 110.w,
                                        child: Image.asset("assets/image/hitting_point_base.png",width: 100.w,height: 100.w,)),
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: OffsetVisualizer(
                                          offsets:  widget.hittingPoints,)
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Positioned(
                          bottom: 55.w,
                          child: AngleGradientVisualization(
                              width: 150.w,height: 68.w,
                              angles: widget.angles),
                        ),
                        Positioned(
                            bottom: 55.w,
                            child: Container(
                                child: HighLightTxtWidget(width:240.w, height: 220.w,angle: widget.mostAngle,percent: widget.mostAnglePercent,))),
                        Positioned(
                            bottom: 0,
                            child: HittingHighLightWidget(width: 150.w, height: 150.w,
                                angle:widget.mostAngle, percent: widget.mostHittingPercent, redOffset: widget.mostHittingPoint))
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          child: HeatMapIndicator())),
                ],
              ),
            )),
      ],
    );
  }
}
