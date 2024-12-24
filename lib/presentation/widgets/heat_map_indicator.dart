import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeatMapIndicator extends StatefulWidget {
  const HeatMapIndicator({super.key});

  @override
  State<HeatMapIndicator> createState() => _HeatMapIndicatorState();
}

class _HeatMapIndicatorState extends State<HeatMapIndicator> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 70.w,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "10%",
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffA0A0A0),
                ),
              ),
              Text(
                "30%",
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffA0A0A0),
                ),
              ),
              Text(
                "50%",
                style: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffA0A0A0),
                ),
              )
            ],
          ),
          SizedBox(width: 8.w,),
          Container(
            width: 5.w,
            height: 62.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.lightGreenAccent,Colors.greenAccent,Colors.yellowAccent,Colors.red],
                  stops: [0,0.4,0.5,1.0]
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도
                  spreadRadius: 0, // 그림자 크기 확장
                  blurRadius: 4, // 그림자 흐림 정도
                  offset: Offset(0, 4), // 그림자 위치 (x, y)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
