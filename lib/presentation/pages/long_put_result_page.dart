import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/helper/long_put_calculator.dart';
import 'package:ginovo_result/presentation/widgets/long_put_panel.dart';
import 'package:ginovo_result/presentation/widgets/putter_panel.dart';
import 'package:ginovo_result/presentation/widgets/rotation_panel.dart';
import 'package:ginovo_result/presentation/widgets/web_3d_viewer.dart';
import 'package:vector_math/vector_math_64.dart' as vec;
import '../widgets/data_panel.dart';
class LongPutResultPage extends StatefulWidget {
  const LongPutResultPage({super.key});

  @override
  State<LongPutResultPage> createState() => _LongPutResultPageState();
}

class _LongPutResultPageState extends State<LongPutResultPage> {
  double spinAngle = -20;

  bool isTransPoints = false;
  List<vec.Vector2> points = [
    vec.Vector2(0, 0),
    vec.Vector2(20,300),
  ];

  List<vec.Vector2> skidPoints = [
    vec.Vector2(0, 0),
    vec.Vector2(0,40),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((e){
      setState(() {
        points =  LongPutCalculator.instance.translatePoints(width: 90,height: 300, points: points);
        skidPoints =  LongPutCalculator.instance.translatePoints(width: 90,height: 300, points: skidPoints);
        isTransPoints = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            children: [
              //#region 앱바 부분
              Container(
                child: Row(
                  children: [
                    SizedBox(width: 8.w,),
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text("그린 스피드"),
                          SizedBox(width: 8.w,),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Text("3.0",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                              )),
                          SizedBox(width: 25.w,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //#endregion
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //#region Section 1
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: [
                              SizedBox(height: 10.w,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("퍼팅 결과",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 24.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.w,),
                              //#region 매트 부분
                              LongPutPanel(points: points, skidPoints: skidPoints,targetDistance: 5.0,),
                              //#endregion
                              SizedBox(height: 20.w,),
                              Row(
                                children: [
                                  Expanded(child: DataPanel(title: "타격 시간", value: "1.2s")),
                                  SizedBox(width: 12.w,),
                                  Expanded(child: DataPanel(title: "초기 속도", value: "1.7m/s"))
                                ],
                              ),
                              SizedBox(height: 16.w,),
                              Row(
                                children: [
                                  Expanded(child: DataPanel(title: "충격량", value: "0.04N")),
                                  SizedBox(width: 12.w,),
                                  Expanded(child: DataPanel(title: "그린 스피드", value: "3.0"))
                                ],
                              ),
                              SizedBox(height: 24.w,),
                            ],
                          ),
                        ),
                        //#endregion
                        Container(
                          color: const Color(0xffF0F0F0),
                          width: double.maxFinite,
                          height: 8.w,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            children: [
                              RotationSection(spinAngle: spinAngle, spinRPM: 1200, hitPoint: const Offset(-40, 10),spinType: SpinType.top,),
                              const PutterSection( topAngle:20,sideAngle:15),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
