import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/main.dart';
import 'package:ginovo_result/presentation/widgets/mat_panel.dart';
import 'package:ginovo_result/presentation/widgets/putter_panel.dart';
import 'package:ginovo_result/presentation/widgets/web_3d_viewer.dart';

import 'package:vector_math/vector_math_64.dart' as vec;

import '../../../helper/mat_calculator.dart';
import '../../widgets/data_panel.dart';
import '../../widgets/rotation_panel.dart';

class MatResultPage extends StatefulWidget {
  const MatResultPage({
    super.key,
    required this.points,
    required this.skidPoints,
    required this.greenSpeedTxt,
    required this.startPoint,
    required this.endPoint,
    required this.pathTxt,
    required this.gapDistanceTxt,
    required this.puttingDistanceTxt,
    required this.skidDistanceTxt,
    required this.launchAngleTxt,
    required this.hittingTimeTxt,
    required this.initialSpeedTxt,
    required this.hittingAmountTxt,
    required this.spinAxisAngle,
    required this.spinRPM,
    required this.hittingPos,
    required this.spinType,
    required this.putterLRAngle,
    required this.putterTBAngle,
  });
  final List<vec.Vector2> points;
  final List<vec.Vector2> skidPoints;
  final String greenSpeedTxt;
  final StartPoint startPoint;
  final EndPoint endPoint;
  final String pathTxt;
  final String gapDistanceTxt;
  final String puttingDistanceTxt;
  final String skidDistanceTxt;
  final String launchAngleTxt;
  final String hittingTimeTxt;
  final String initialSpeedTxt;
  final String hittingAmountTxt;
  final double spinAxisAngle;
  final int spinRPM;
  final Offset hittingPos;
  final SpinType spinType;
  final double putterLRAngle;
  final double putterTBAngle;
  @override
  State<MatResultPage> createState() => _MatResultPageState();
}

class _MatResultPageState extends State<MatResultPage> {

  bool isTransPoints = false;
  List<vec.Vector2> points = [];

  List<vec.Vector2> skidPoints = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((e){
      setState(() {
        points =  MatCalculator.instance.translatePoints(sp: widget.startPoint, points: widget.points);
        skidPoints =  MatCalculator.instance.translatePoints(sp: widget.startPoint, points: widget.skidPoints);
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
                    IconButton(onPressed: (){
                      navigatorKey.currentState?.pop();
                    }, icon: Icon(Icons.arrow_back_ios)),
                    Expanded(
                      child: Row(
                        children: [
                          Text("Path"),
                          Expanded(
                              child:
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${widget.pathTxt}",
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
                          Text("Green Speed"),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${widget.greenSpeedTxt}",
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Text("Putt Results",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 24.sp,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.w),
                                      border: Border.all(color: Color(0xff26DD81),)
                                    ),
                                    child: Text("Mat Mode",
                                    style: TextStyle(
                                      color: Color(0xff26DD81),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 16.w,),
                              //#region 매트 부분
                              isTransPoints?MatPanel(
                                  points: points,
                                  skidPoints: skidPoints,
                                  startPoint: widget.startPoint,
                                  endPoint: widget.endPoint,
                                  isTransPoints: isTransPoints,
                                  gapDistanceTxt: widget.gapDistanceTxt,
                                  puttingDistanceTxt: widget.puttingDistanceTxt,
                                  skidDistanceTxt: widget.skidDistanceTxt,
                                  launchAngleTxt: widget.launchAngleTxt,
                              ):Container(),
                              //#endregion
                              SizedBox(height: 20.w,),
                              Row(
                                children: [
                                  Expanded(child: DataPanel(title: "Impact Time", value: "${widget.hittingTimeTxt}")),
                                  SizedBox(width: 12.w,),
                                  Expanded(child: DataPanel(title: "Ball Speed", value: "${widget.initialSpeedTxt}"))
                                ],
                              ),
                              SizedBox(height: 16.w,),
                              Row(
                                children: [
                                  Expanded(child: DataPanel(title: "Impact", value: "${widget.hittingAmountTxt}")),
                                  SizedBox(width: 12.w,),
                                  Expanded(child: DataPanel(title: "Green Speed", value: "${widget.greenSpeedTxt}"))
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
                              RotationSection(spinAngle: widget.spinAxisAngle, spinRPM: widget.spinRPM, hitPoint: widget.hittingPos,spinType: widget.spinType,),
                              PutterSection( topAngle:widget.putterLRAngle,sideAngle:widget.putterTBAngle),
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
