import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/main.dart';
import 'package:ginovo_result/presentation/pages/result/free_result_page.dart';
import 'package:ginovo_result/presentation/pages/result/mat_result_page.dart';
import 'package:ginovo_result/presentation/widgets/ball_speed_panel.dart';
import 'package:ginovo_result/presentation/widgets/data_panel.dart';
import 'package:ginovo_result/presentation/widgets/distance_bar_widget.dart';
import 'package:ginovo_result/presentation/widgets/angle_gradient_visualization.dart';
import 'package:ginovo_result/presentation/widgets/face_angle_panel.dart';
import 'package:ginovo_result/presentation/widgets/heat_map_indicator.dart';
import 'package:ginovo_result/presentation/widgets/hitting_spin_panel.dart';
import 'package:ginovo_result/presentation/widgets/putt_distance_panel.dart';
import 'package:ginovo_result/presentation/widgets/short_cut_button_panel.dart';
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
                ShortCutButtonPanel(
                  matModeOnClick: (){
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
                          spinRPM: 420,
                          hittingPos: Offset(-40, 10),
                          spinType:  SpinType.top,
                          putterLRAngle: 20.0,
                          putterTBAngle: 15.0,
                          gapDistanceTxt: "R 20cm",
                          puttingDistanceTxt: "3.1m",
                          skidDistanceTxt: "4cm",
                          launchAngleTxt: "R 3.0°",
                        )
                    ));
                  },
                  freeModeOnClick: (){
                    navigatorKey.currentState?.push(MaterialPageRoute(
                        builder: (_)=>FreeResultPage(
                          points: [vec.Vector2(0, 0), vec.Vector2(20,1200),],
                          skidPoints: [vec.Vector2(0, 0), vec.Vector2(0,40),],
                          greenSpeedTxt: '3.0',
                          hittingTimeTxt: '1.2s',
                          initialSpeedTxt: '1.7m/s',
                          hittingAmountTxt: '0.04N',
                          spinAxisAngle: -20,
                          spinRPM: 300,
                          hittingPos: Offset(-40, 10),
                          spinType:  SpinType.top,
                          putterLRAngle: 20.0,
                          putterTBAngle: 15.0,
                          gapDistanceTxt: "R 20cm",
                          puttingDistanceTxt: "3.1m",
                          skidDistanceTxt: "40cm",
                          launchAngleTxt: "R 3.0°",
                        )
                    ));
                  },
                  longPuttOnClick: (){
                    navigatorKey.currentState?.push(MaterialPageRoute(
                          builder: (_)=>LongPutResultPage(
                            points: [vec.Vector2(0, 0), vec.Vector2(20,300),],
                            skidPoints: [vec.Vector2(0, 0), vec.Vector2(0,40),],
                            greenSpeedTxt: '3.0',
                            targetDistance: 300,
                            hittingTimeTxt: '1.2s',
                            initialSpeedTxt: '1.7m/s',
                            hittingAmountTxt: '0.04N',
                            spinAxisAngle: -20,
                            spinRPM: 420,
                            hittingPos: Offset(-40, 10),
                            spinType:  SpinType.top,
                            putterLRAngle: 20.0,
                            putterTBAngle: 15.0,
                            gapDistanceTxt: "R 20cm",
                            puttingDistanceTxt: "3.1m",
                            skidDistanceTxt: "4cm",
                            launchAngleTxt: "R 3.0°",
                          )
                      ));
                  },
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
                      HittingSpinPanel(
                          hittingPoints: [
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
                          ],
                          angles: [0,15,30,45,60,75,90,-15,-30,-45,-60,-75,-90],
                          mostAngle: 10,
                          mostAnglePercent: 40,
                          mostHittingPoint: Offset(15,30),
                          mostHittingPercent: 60,
                      ),
                      SizedBox(height: 30.w,),
                      PuttDistancePanel(data: [
                        DistanceBarElementModel(realDistance: 0.98,baseDistance: 1, index: 0,),
                        DistanceBarElementModel(realDistance: 2.2,baseDistance: 2, index: 1,),
                        DistanceBarElementModel(realDistance: 2.7,baseDistance: 3, index: 2,),
                        DistanceBarElementModel(realDistance: 6,baseDistance: 4, index: 3,),
                      ],),
                      SizedBox(height: 30.w,),
                      BallSpeedPanel(
                        greenSpeedCallBack: (greenSpeed){},
                        data: [
                        SpeedBarElementModel(realSpeed: 0.6, baseSpeed: 0.8, targetDistance:1, index: 0),
                        SpeedBarElementModel(realSpeed: 1.6, baseSpeed: 1.4, targetDistance:2, index: 1),
                        SpeedBarElementModel(realSpeed: 1.9, baseSpeed: 2.2, targetDistance:3, index: 2),
                        SpeedBarElementModel(realSpeed: 3.2, baseSpeed: 2.9, targetDistance:5, index: 3),
                        SpeedBarElementModel(realSpeed: 0.6, baseSpeed: 3.2, targetDistance:1, index: 4),
                        SpeedBarElementModel(realSpeed: 1.6, baseSpeed: 3.8, targetDistance:2, index: 5),
                        SpeedBarElementModel(realSpeed: 1.9, baseSpeed: 4.1, targetDistance:3, index: 6),
                        SpeedBarElementModel(realSpeed: 3.2, baseSpeed: 4.9, targetDistance:5, index: 7),
                      ],),
                      SizedBox(height: 30.w,),
                      FaceAnglePanel(
                        mostTopAngle:  5,
                        mostTopPercent: 40,
                        topAngles: [5,1,2,3,4,5,5,5,5,6,7,8,9,-1,-2,-3,-4],
                        mostSideAngle: -5,
                        mostSidePercent: 45,
                        sideAngles: [0,-5,-5,-5,-5,-5,-5,5,5,10,15],
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
