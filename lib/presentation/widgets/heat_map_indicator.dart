import 'dart:math';

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
                "50%",
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
                "10%",
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
class OffsetVisualizer extends StatelessWidget {
  final List<Offset> offsets;

  OffsetVisualizer({required this.offsets});

  @override
  Widget build(BuildContext context) {
    // 동일한 Offset의 개수를 계산
    final Map<Offset, int> offsetCounts = {};
    for (var offset in offsets) {
      offsetCounts[offset] = (offsetCounts[offset] ?? 0) + 1;
    }

    // 최대 등장 횟수 계산
    final int maxCount = offsetCounts.values.fold(0, (prev, element) => prev > element ? prev : element);

    return Container(
        child: LayoutBuilder(builder: (ctx,constraints){
          final centerX = constraints.maxWidth / 2;
          final centerY = constraints.maxHeight / 2;
          return  Stack(
            children: offsetCounts.entries.map((entry) {
              final offset = entry.key;
              final count = entry.value;
              List<List<Color>> colorSets = [
                [Colors.lightGreenAccent, Colors.lightGreenAccent.shade400],
                [Colors.yellowAccent,Colors.lightGreenAccent.shade100],
                [Colors.orangeAccent,Colors.yellowAccent],
                [Colors.red, Colors.orangeAccent],
              ];
              // Radial Gradient 설정
              final gradient = RadialGradient(
                colors: count==1?colorSets[0]:count==2?colorSets[1]:count==3?colorSets[2]:colorSets[3],
                stops: [0,1],
                center: Alignment(0, 0),
              );

              return Positioned(
                left: centerX + offset.dx.w - 4.w, // 중심점 기준 Offset
                top: centerY - offset.dy.w - 4.w, // 중심점 기준 Offset
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: gradient,
                  ),
                  alignment: Alignment.center,
                ),
              );
            }).toList(),
          );
        }),
    );
  }
}