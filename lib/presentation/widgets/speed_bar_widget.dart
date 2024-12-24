import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeedBarWidget extends StatefulWidget {
  const SpeedBarWidget({
    super.key,
    required this.realSpeed,
    required this.baseSpeed,
    required this.targetDistance,
    required this.index,
  });
  final double realSpeed;
  final double baseSpeed;
  final double targetDistance;
  final int index;
  @override
  State<SpeedBarWidget> createState() => _SpeedBarWidgetState();
}

class _SpeedBarWidgetState extends State<SpeedBarWidget> {
  List colorList = [
    Color(0xffFC5C66),
    Color(0xff45AAF2),
    Color(0xffA55EEA),
    Color(0xff26DD81)
  ];
  @override
  Widget build(BuildContext context) {
    final targetColor = colorList.elementAt(widget.index%4);
    final targetPercent = (widget.realSpeed/widget.baseSpeed*100);
    return Container(
      width: 42.w,
      child: Column(
        children: [
          Text("${widget.realSpeed.toStringAsFixed(2).replaceAll(RegExp(r'\.?0+$'), '')}",
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
            height: (26 *(1+0.2*widget.index) * (1+((widget.realSpeed-widget.baseSpeed)*0.2))).w,
            decoration: BoxDecoration(
              color: targetColor,
              borderRadius: BorderRadius.circular(2.w),
            ),
          ),
          SizedBox(height: 8.w,),
          Text("${widget.targetDistance.toStringAsFixed(0)}m",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12.sp,
              color: Color(0xff000000),
            ),
          ),
          SizedBox(height: 4.w,),
          Text("${widget.baseSpeed.toStringAsFixed(2).replaceAll(RegExp(r'\.?0+$'), '')}",
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

class GreenSpeedDropdown extends StatefulWidget {
  GreenSpeedDropdown({super.key,
    required this.onChangedCallback,
  });
  Function onChangedCallback;
  @override
  State<GreenSpeedDropdown> createState() => _GreenSpeedDropdownState();
}

class _GreenSpeedDropdownState extends State<GreenSpeedDropdown> {
  // 초기 선택값
  double selectedValue = 3.0;

  // 드롭다운 메뉴 아이템
  final List<double> dropdownItems = [2.5,2.8,3.0,3.2];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: Color(0xfffbfbfb),
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: DropdownButton<double>(
        value: selectedValue,
        hint: Text("롱펏 모드 - 그린스피드 ${selectedValue.toStringAsFixed(1)}"),
        items: dropdownItems.map((double item) {
          return DropdownMenuItem<double>(
            value: item,
            child: Container(child: Text("롱펏 모드 - 그린스피드 ${item.toStringAsFixed(1)}")),
          );
        }).toList(),
        onChanged: (double? newValue) {
          setState(() {
            selectedValue = newValue??3.0;
            widget.onChangedCallback(newValue??3.0);
          });
        },
        // 스타일 설정
        icon: Icon(Icons.arrow_drop_down),
        style:TextStyle(color: Colors.black, fontSize: 10.sp,),
        underline:SizedBox.shrink(),
        dropdownColor: Color(0xfffbfbfb),
        borderRadius: BorderRadius.circular(20.w),

      ),
    );
  }
}

