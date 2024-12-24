import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataPanel extends StatelessWidget {
  final String title;
  final String value;
  const DataPanel({super.key,required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 16.w),
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
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("${title}",
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xff7A7A7A),
            ),
            ),
          ),
          SizedBox(height: 16.w,),
          Align(
            alignment: Alignment.centerRight,
            child: Text("${value}",
            style: TextStyle(
              fontSize: 24.sp,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
            ),
          )
        ],
      ),
    );
  }
}


class PanelContainer extends StatefulWidget {
  const PanelContainer({
    super.key,
    required this.titleWidget,
    required this.childWidget});
  final Widget titleWidget;
  final Widget childWidget;
  @override
  State<PanelContainer> createState() => _PanelContainerState();
}

class _PanelContainerState extends State<PanelContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.maxFinite,
      padding: EdgeInsets.all(24.w),
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
        children: [
          widget.titleWidget,
          SizedBox(height: 16.w,),
          widget.childWidget,
        ],
      ),
    );
  }
}

