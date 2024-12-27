import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/main.dart';
import 'package:ginovo_result/presentation/pages/result/mat_result_page.dart';
import 'package:ginovo_result/presentation/widgets/data_panel.dart';
import 'package:ginovo_result/presentation/widgets/distance_bar_widget.dart';
import 'package:ginovo_result/presentation/widgets/angle_gradient_visualization.dart';
import 'package:ginovo_result/presentation/widgets/heat_map_indicator.dart';
import 'package:ginovo_result/presentation/widgets/speed_bar_widget.dart';
import 'package:vector_math/vector_math_64.dart' as vec;
import '../../../helper/mat_calculator.dart';
import '../../widgets/web_3d_viewer.dart';
import '../result/long_put_result_page.dart';

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.w,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("GINOVO",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),),
                  ),
                ),
                SizedBox(height: 40.w,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: PanelContainer(
                    customPadding: EdgeInsets.symmetric(vertical: 16.w,horizontal: 20.w),
                      childWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                            navigatorKey.currentState?.push(MaterialPageRoute(
                                builder: (_)=>MatResultPage(
                                  points: [vec.Vector2(0, 0), vec.Vector2(20,300),],
                                  skidPoints: [vec.Vector2(0, 0), vec.Vector2(0,40),],
                                  greenSpeedTxt: '3.0',
                                  startPoint: StartPoint.b,
                                  endPoint: EndPoint.A,
                                  pathTxt: "b -> A",
                                  hittingTimeTxt: '1.2s',
                                  initialSpeedTxt: '1.7m/s',
                                  hittingAmountTxt: '0.04N',
                                  spinAxisAngle: 5,
                                  spinRPM: 1200,
                                  hittingPos: Offset(-40, 10),
                                  spinType:  SpinType.top,
                                  putterLRAngle: 20.0,
                                  putterTBAngle: 15.0,
                                  gapDistanceTxt: "R 0.2m",
                                  puttingDistanceTxt: "3.1m",
                                  skidDistanceTxt: "0.2m",
                                  launchAngleTxt: "R 3.0°",
                                )
                            ));
                        },
                        child: Column(
                          children: [
                            Image.asset("assets/image/mat_mode.png",width: 48.w,),
                            Text("GINOVO\nMat Mode",
                            textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff4C4C4C)
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Column(
                          children: [
                            Image.asset("assets/image/free_mode.png",width: 48.w,),
                            Text("Free\nMode",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff4C4C4C)
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          navigatorKey.currentState?.push(
                            MaterialPageRoute(
                                builder: (_)=>LongPutResultPage(
                                  points: [vec.Vector2(0, 0), vec.Vector2(20,300),],
                                  skidPoints: [vec.Vector2(0, 0), vec.Vector2(0,40),],
                                  greenSpeedTxt: '3.0',
                                  targetDistance: 300,
                                  hittingTimeTxt: '1.2s',
                                  initialSpeedTxt: '1.7m/s',
                                  hittingAmountTxt: '0.04N',
                                  spinAxisAngle: -20,
                                  spinRPM: 1200,
                                  hittingPos: Offset(-40, 10),
                                  spinType:  SpinType.top,
                                  putterLRAngle: 20.0,
                                  putterTBAngle: 15.0,
                                  gapDistanceTxt: "R 0.2m",
                                  puttingDistanceTxt: "3.1m",
                                  skidDistanceTxt: "0.2m",
                                  launchAngleTxt: "R 3.0°",
                                )
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset("assets/image/longput_mode.png",width: 48.w,),
                            Text("LongPutt\nMode",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff4C4C4C)
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  )),
                ),
                SizedBox(height: 30.w,),
                Container(
                  width:double.maxFinite,
                  height: 4.w,
                  color: Color(0xffEAEAEA),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 16.w,),
                      Row(
                        children: [
                          Expanded(
                            child: Text("Putt Analysis",
                              style: TextStyle(
                                  fontWeight:FontWeight.w500,
                                  fontSize: 24.sp,
                                  color: Color(0xff000000)
                              ),
                            ),
                          ),
                          Text("Base Date 12/25",
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
                            child: Text("RBI & Spin",
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
                                            ],
                                          )),
                                      Positioned(
                                        bottom: 55.w,
                                        child: AngleGradientVisualization(
                                            width: 150.w,height: 68.w,
                                            angles: [0,30,-30,60,-60,90,-90]),
                                      ),
                                      Positioned(
                                          bottom: 55.w,
                                          child: Container(
                                              child: HighLightTxtWidget(width:240.w, height: 220.w,angle: 10,percent: 40,))),
                                      Positioned(
                                          bottom: 0,
                                          child: HittingHighLightWidget(width: 150.w, height: 150.w,
                                          angle: 5, percent: 65, redOffset: Offset(10, 10)))
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
                            child: Text("putt distance(m)",
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
                                    Text("Hitting Target",
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
                                  Text("Ball Speed",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Text("Unit m/s",
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
                                    Text("Target Distance",
                                      style: TextStyle(
                                        fontSize:8.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff474747),
                                      ),
                                    ),
                                    SizedBox(height: 8.w,),
                                    Text("Standard Speed",
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
                                            HighLightTxtWidget(width:200.w, height: 180.w,angle: 12,percent: 40,),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Center(
                                                child: Container(
                                                  child: AngleGradientVisualization(
                                                      width: 130.w,height: 120.w,
                                                      angles:[-30,-1,1,1,1,2,-3,4,1,2,3,-4,12,3,14,12,1,-2,3,-1,1,1,1,2,-3,4,1,2,3,-4,12,3,14,12,1,-2,3]),
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
                                          QuaterHighLightTxtWidget(width:100.w, height: 200.w,angle: 39,percent: 40,),
                                           Positioned(
                                             bottom: 0,
                                             child: QuaterAngleGradientVisualization(
                                              width: 68.w,height: 68.w,
                                                angles: [0,30,45,45,45,45,45,45,45,46,46,46,47,47,47,48,48,48,44,44,44,44,43,43,43,42,42,41,40,39,38,37,36,35,34,34,33,]),
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
                      SizedBox(height: 30.w,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
