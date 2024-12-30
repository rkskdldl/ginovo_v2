import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/presentation/widgets/data_panel.dart';
import 'package:ginovo_result/presentation/widgets/speed_bar_widget.dart';

class BallSpeedPanel extends StatefulWidget {
  const BallSpeedPanel({
    super.key,
    required this.data,
    required this.greenSpeedCallBack
  });
  final List<SpeedBarElementModel> data;
  final Function greenSpeedCallBack;
  @override
  State<BallSpeedPanel> createState() => _BallSpeedPanelState();
}

class _BallSpeedPanelState extends State<BallSpeedPanel> {
  List<SpeedBarElementModel> data = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp){
      setState(() {
        data = widget.data;
        data.sort((a,b)=>a.index.compareTo(b.index));
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PanelContainer(
        titleWidget: Column(
          children: [
            //그린스피드 선택 드롭다운
            Align(
              alignment: Alignment.centerLeft,
              child: GreenSpeedDropdown(
                  onChangedCallback: (greenSpeed){
                    // 변경된 그린스피드 콜백함수 (double로 리턴)
                    widget.greenSpeedCallBack(greenSpeed);
                  }
              ),
            ),
            SizedBox(height: 6.w,),
            Row(
              children: [
                Text("Ball Speed",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text("Unit m/s",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Color(0xff646464),

                  ),
                )
              ],
            ),
          ],
        ),
        childWidget:Container(
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Target Distance",
                    style: TextStyle(
                      fontSize:8.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff474747),
                    ),
                  ),
                  SizedBox(height: 8.w,),
                  Text("Standard Speed",
                    style: TextStyle(
                      fontSize:8.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff474747),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  child:LayoutBuilder(builder: (ctx,constraints){
                    return  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        constraints: BoxConstraints(minWidth: constraints.maxWidth),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ...data.map((e)=>SpeedBarWidget(realSpeed: e.realSpeed, baseSpeed: e.baseSpeed, targetDistance: e.targetDistance, index: e.index)).toList(),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}

class SpeedBarElementModel{
  double realSpeed;
  double baseSpeed;
  double targetDistance;
  int index;

  SpeedBarElementModel({
    required this.realSpeed,
    required this.baseSpeed,
    required this.targetDistance,
    required this.index,
  });
}