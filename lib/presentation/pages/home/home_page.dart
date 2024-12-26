import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/presentation/widgets/data_panel.dart';
import 'package:ginovo_result/presentation/widgets/distance_bar_widget.dart';
import 'package:ginovo_result/presentation/widgets/angle_gradient_visualization.dart';
import 'package:ginovo_result/presentation/widgets/heat_map_indicator.dart';
import 'package:ginovo_result/presentation/widgets/speed_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFBFBFB),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.w,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("GINOVO",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
                SizedBox(height: 16.w,),
                Row(
                  children: [
                    Expanded(
                      child: Text("퍼팅 분석",
                        style: TextStyle(
                            fontWeight:FontWeight.w500,
                            fontSize: 24.sp,
                            color: Color(0xff000000)
                        ),
                      ),
                    ),
                    Text("기준일 12월 25일 ",
                      style: TextStyle(
                        fontWeight:FontWeight.normal,
                        fontSize: 8.sp,
                        color: Color(0xff3A3A3A)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.w,),
                PanelContainer(
                    titleWidget: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("타점 & 스핀",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    childWidget:Container(
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset("assets/image/hitting_point_base.png",width: 100.w,),
                                Positioned(
                                  left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: OffsetVisualizer(
                                        offsets:  [
                                          Offset(0, 0),
                                          Offset(0, 0),
                                          Offset(10, 10),
                                          Offset(20, 20),
                                          Offset(10, 10),
                                          Offset(30, 30),
                                          Offset(10, 10),
                                          Offset(20, 20),
                                          Offset(20, 20),
                                          Offset(20, 20),
                                          Offset(40,0),
                                          Offset(40,0),
                                          Offset(40,0),
                                          Offset(50,0),
                                          Offset(0,50),
                                          Offset(-50,0),
                                        ],)
                                ),
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
                SizedBox(height: 30.w,),
                PanelContainer(
                    titleWidget: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("퍼팅 거리(m)",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    childWidget:Container(
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("타격목표",
                              style: TextStyle(
                                fontSize:8.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff474747),
                              ),
                              ),
                              SizedBox(height: 8.w,),
                              Text("",
                                style: TextStyle(
                                  fontSize:8.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff474747),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: Container(
                              width: double.maxFinite,
                              child:LayoutBuilder(builder: (ctx,constraints){
                                return  SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        DistanceBarWidget(realDistance: 0.98,baseDistance: 1, index: 0,),
                                        DistanceBarWidget(realDistance: 2.2,baseDistance: 2, index: 1,),
                                        DistanceBarWidget(realDistance: 2.7,baseDistance: 3, index: 2,),
                                        DistanceBarWidget(realDistance: 6,baseDistance: 4, index: 3,),

                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: 30.w,),
                PanelContainer(
                    titleWidget: Column(
                      children: [
                        //그린스피드 선택 드롭다운
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GreenSpeedDropdown(
                              onChangedCallback: (greenSpeed){
                                // 변경된 그린스피드 콜백함수 (double로 리턴)

                              }
                          ),
                        ),
                        SizedBox(height: 6.w,),
                        Row(
                          children: [
                            Text("볼 스피드",
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Text("단위 m/s",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Color(0xff646464),

                            ),
                            )
                          ],
                        ),
                      ],
                    ),
                    childWidget:Container(
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("목표거리",
                                style: TextStyle(
                                  fontSize:8.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff474747),
                                ),
                              ),
                              SizedBox(height: 8.w,),
                              Text("기준 스피드",
                                style: TextStyle(
                                  fontSize:8.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff474747),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: Container(
                              width: double.maxFinite,
                              child:LayoutBuilder(builder: (ctx,constraints){
                                return  SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SpeedBarWidget(realSpeed: 0.6, baseSpeed: 0.8, targetDistance:1, index: 0),
                                        SpeedBarWidget(realSpeed: 1.6, baseSpeed: 1.4, targetDistance:2, index: 1),
                                        SpeedBarWidget(realSpeed: 1.9, baseSpeed: 2.2, targetDistance:3, index: 2),
                                        SpeedBarWidget(realSpeed: 3.2, baseSpeed: 2.9, targetDistance:5, index: 3),
                                        SpeedBarWidget(realSpeed: 0.6, baseSpeed: 3.2, targetDistance:1, index: 4),
                                        SpeedBarWidget(realSpeed: 1.6, baseSpeed: 3.8, targetDistance:2, index: 5),
                                        SpeedBarWidget(realSpeed: 1.9, baseSpeed: 4.1, targetDistance:3, index: 6),
                                        SpeedBarWidget(realSpeed: 3.2, baseSpeed: 4.9, targetDistance:5, index: 7),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: 30.w,),
                PanelContainer(
                    titleWidget: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("페이스 각",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    childWidget:Container(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              AngleGradientVisualization(
                                  width: 300.w,height: 300.w,
                                  angles:[-90,-75,-60,-45,-30,-15,0,0,0,0,15,30,45,60,75,90,
                                  -45,-45
                                  ]),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Center(child: SemiCircleAngleWidget(width: 230.w, height: 230.w))),
                            ],
                          ),
                          Image.asset('assets/image/putter_top_single.png',width: 24.w,),
                        ],
                      ),
                    )),
                SizedBox(height: 30.w,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
