import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/presentation/widgets/web_3d_viewer.dart';

import '../../helper/mat_calculator.dart';
import '../../main.dart';
import '../pages/result/long_put_result_page.dart';
import '../pages/result/mat_result_page.dart';
import 'data_panel.dart';
import 'package:vector_math/vector_math_64.dart' as vec;
class ShortCutButtonPanel extends StatefulWidget {
  const ShortCutButtonPanel({super.key,
    required this.matModeOnClick,
    required this.freeModeOnClick,
    required this.longPuttOnClick,
  });
  final Function matModeOnClick;
  final Function freeModeOnClick;
  final Function longPuttOnClick;
  @override
  State<ShortCutButtonPanel> createState() => _ShortCutButtonPanelState();
}

class _ShortCutButtonPanelState extends State<ShortCutButtonPanel> {
  @override
  Widget build(BuildContext context) {
    return                 Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: PanelContainer(
          customPadding: EdgeInsets.symmetric(vertical: 16.w,horizontal: 20.w),
          childWidget: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (){

                },
                child: Column(
                  children: [
                    Image.asset("assets/image/mat_mode.png",width: 48.w,),
                    Text("GINOVO\nMat Mode",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4C4C4C)
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Column(
                  children: [
                    Image.asset("assets/image/free_mode.png",width: 48.w,),
                    Text("Free\nMode",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4C4C4C)
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  navigatorKey.currentState?.push(
                    MaterialPageRoute(
                        builder: (_)=>LongPutResultPage(
                          points: [vec.Vector2(0, 0), vec.Vector2(20,300),],
                          skidPoints: [vec.Vector2(0, 0), vec.Vector2(0,40),],
                          greenSpeedTxt: '3.0',
                          targetDistance: 300,
                          hittingTimeTxt: '1.2s',
                          initialSpeedTxt: '1.7m/s',
                          hittingAmountTxt: '0.04N',
                          spinAxisAngle: -20,
                          spinRPM: 1200,
                          hittingPos: Offset(-40, 10),
                          spinType:  SpinType.top,
                          putterLRAngle: 20.0,
                          putterTBAngle: 15.0,
                          gapDistanceTxt: "R 0.2m",
                          puttingDistanceTxt: "3.1m",
                          skidDistanceTxt: "0.2m",
                          launchAngleTxt: "R 3.0°",
                        )
                    ),
                  );
                },
                child: Column(
                  children: [
                    Image.asset("assets/image/longput_mode.png",width: 48.w,),
                    Text("LongPutt\nMode",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff4C4C4C)
                      ),
                    ),
                  ],
                ),
              ),

            ],
          )),
    );
  }
}
