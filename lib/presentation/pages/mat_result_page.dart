import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/presentation/widgets/putter_panel.dart';
import 'package:ginovo_result/presentation/widgets/web_3d_viewer.dart';

import 'package:vector_math/vector_math_64.dart' as vec;

import '../../helper/mat_calculator.dart';
import '../widgets/DashedLine.dart';
import '../widgets/data_panel.dart';
import '../widgets/growing_dashed_line.dart';
class MatResultPage extends StatefulWidget {
  const MatResultPage({super.key});

  @override
  State<MatResultPage> createState() => _MatResultPageState();
}

class _MatResultPageState extends State<MatResultPage> {


  bool isTransPoints = false;
  List<vec.Vector2> points = [
    vec.Vector2(0, 0),
    vec.Vector2(0,300),
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
        points =  MatCalculator.instance.translatePoints(sp: startPoint, points: points);
        skidPoints =  MatCalculator.instance.translatePoints(sp: startPoint, points: skidPoints);
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
                          Text("Path"),
                          Expanded(
                              child:
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("b -> B",
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
                    Container(
                      width: 1.w,
                      height: 31.w,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 20.w,),
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
                              Row(
                                children: [
                                  const Spacer(),
                                  Stack(
                                    children: [
                                      SizedBox(
                                          width: 132.w,
                                          height: MatCalculator.convertHeight.w,
                                          child: Image.asset("assets/image/mat_90_grey.png")
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
                                              startPoint:MatCalculator.instance.getStartPoint(sp:startPoint),
                                              endPoint: MatCalculator.instance.getEndPoint(ep:endPoint)),
                                        ),
                                      ),
                                      isTransPoints?Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        bottom: 0,
                                        child : SizedBox(
                                            width: 132.w,
                                            height: MatCalculator.convertHeight.w,
                                            child: SmoothGrowingDashedLine(points: points,color: Colors.green,)),
                                      ):Container(),
                                      isTransPoints?Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        bottom: 0,
                                        child : SizedBox(
                                            width: 132.w,
                                            height: MatCalculator.convertHeight.w,
                                            child: SmoothGrowingDashedLine(points: skidPoints,color: Colors.red,isShowArrow: false,duration: Duration(seconds: 2),)),
                                      ):Container(),
                                    ],
                                  ),
                                  Expanded(
                                      child: Container(
                                        height: MatCalculator.convertHeight.w,
                                        padding: EdgeInsets.only(left: 16.w),
                                        child: Stack(
                                          children: [
                                            Container(),
                                            Positioned(
                                              top:points.last.y,
                                              left: 0,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("이격거리",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color(0xff7A7A7A),
                                                    ),
                                                  ),
                                                  Text("0.02m",
                                                    style: TextStyle(
                                                        fontSize: 24.sp,
                                                        color: Color(0xff000000),
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top:(points.first.y+points.last.y)/2,
                                              left: 0,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("이동거리",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color(0xff7A7A7A),
                                                    ),
                                                  ),
                                                  Text("3.1m",
                                                    style: TextStyle(
                                                        fontSize: 24.sp,
                                                        color: Color(0xff000000),
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 40.w,
                                              left: 0,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("스키드 거리",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color(0xff7A7A7A),
                                                    ),
                                                  ),
                                                  Text("0.2m",
                                                    style: TextStyle(
                                                        fontSize: 24.sp,
                                                        color: Color(0xff000000),
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("이격각",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: Color(0xff7A7A7A),
                                                    ),
                                                  ),
                                                  Text("3.0°",
                                                    style: TextStyle(
                                                        fontSize: 24.sp,
                                                        color: Color(0xff000000),
                                                        fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                ],
                              ),
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
                                      SizedBox(
                                        width:240.w,
                                        height:240.w,
                                        child: Container(child: Web3dViewer()),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              PutterSection(),
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
