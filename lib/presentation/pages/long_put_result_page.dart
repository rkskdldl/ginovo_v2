import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/helper/long_put_calculator.dart';
import 'package:ginovo_result/presentation/widgets/long_put_panel.dart';
import 'package:ginovo_result/presentation/widgets/putter_panel.dart';
import 'package:ginovo_result/presentation/widgets/web_3d_viewer.dart';

import 'package:vector_math/vector_math_64.dart' as vec;

import '../../helper/mat_calculator.dart';
import '../widgets/DashedLine.dart';
import '../widgets/data_panel.dart';
import '../widgets/growing_dashed_line.dart';
class LongPutResultPage extends StatefulWidget {
  const LongPutResultPage({super.key});

  @override
  State<LongPutResultPage> createState() => _LongPutResultPageState();
}

class _LongPutResultPageState extends State<LongPutResultPage> {


  bool isTransPoints = false;
  List<vec.Vector2> points = [
    vec.Vector2(0, 0),
    vec.Vector2(5,300),
  ];

  List<vec.Vector2> skidPoints = [
    vec.Vector2(0, 0),
    vec.Vector2(0,40),
  ];
  StartPoint startPoint = StartPoint.b;
  EndPoint endPoint = EndPoint.B;
  //중간 포인트
  //L  M  R 키워드 알파벳 문자
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
                        children: [
                          Text("그린 스피드"),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("3.0",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                    ),
                                  ))
                          ),
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
                              LongPutPanel(points: points, skidPoints: skidPoints,),
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
                              SizedBox(height: 40.w,),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("회전",
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
                                            Text("3000",
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
                                        children: [
                                          SizedBox(
                                            width:240.w,
                                            height:240.w,
                                            child: Container(child: Web3dViewer(spinAngle:20)),
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
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              PutterSection( topAngle:20,sideAngle:15),
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
