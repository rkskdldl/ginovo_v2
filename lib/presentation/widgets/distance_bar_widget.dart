import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DistanceBarWidget extends StatefulWidget {
  const DistanceBarWidget({super.key,required this.realDistance,required this.baseDistance,required this.index});
  final double realDistance;
  final double baseDistance;
  final int index;
  @override
  State<DistanceBarWidget> createState() => _DistanceBarWidgetState();
}

class _DistanceBarWidgetState extends State<DistanceBarWidget> {
  List colorList = [
    Color(0xffFC5C66),
    Color(0xff45AAF2),
    Color(0xffA55EEA),
    Color(0xff26DD81)
  ];

  @override
  Widget build(BuildContext context) {
    final targetColor = colorList.elementAt(widget.index%4);
    final targetPercent = ((widget.realDistance/widget.baseDistance*100)-100);
    return Container(
      width: 42.w,
      child: Column(
        children: [
          Text("${widget.realDistance.toStringAsFixed(2).replaceAll(RegExp(r'\.?0+$'), '')}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: targetColor,
            ),
          ),
          SizedBox(height: 6.w,),
          Container(
            width: 14.w,
            // width: 24.w, old
            height: (26 *(1+0.2*widget.index) * (1+((widget.realDistance-widget.baseDistance)*0.2))).w,
            decoration: BoxDecoration(
                color: targetColor,
                borderRadius: BorderRadius.circular(2.w),
            ),
          ),
          SizedBox(height: 8.w,),
          Text("${widget.baseDistance.toStringAsFixed(0)}m",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12.sp,
              color: Color(0xff000000),
            ),
          ),
          SizedBox(height: 4.w,),
          Text("${targetPercent>0?"+":""}${targetPercent.toStringAsFixed(0)}%",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 10.sp,
              color:Color(0xff909090),
            ),
          ),
        ],
      ),
    );
  }
}
