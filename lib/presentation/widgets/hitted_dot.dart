import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HittedDot extends StatefulWidget {
  const HittedDot({super.key});

  @override
  State<HittedDot> createState() => _HittedDotState();
}

class _HittedDotState extends State<HittedDot> {
  double _ballSize = 12;
  bool active = true;
  // 효과를 트리거하는 함수
  void _triggerScaleEffect() {
    setState(() {
      _ballSize = 24; // 공의 크기를 키움
    });
    // 일정 시간 후 원래 크기로 돌아감
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _ballSize = 12; // 원래 크기로 돌아감
      });
    });

    Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        active =false;
      });
    });
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2000),(){
      _triggerScaleEffect();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return active?AnimatedContainer(
      duration: Duration(milliseconds: 1000), // 애니메이션 지속 시간
      curve: Curves.easeInOut, // 부드러운 곡선 효과
      width: _ballSize.w,
      height: _ballSize.w,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
    ):Container();
  }
}
