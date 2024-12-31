import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/presentation/pages/history/history_page.dart';
import 'package:ginovo_result/presentation/pages/home/home_page.dart';
import 'package:ginovo_result/presentation/pages/result/long_put_result_page.dart';
import 'package:ginovo_result/presentation/widgets/web_3d_viewer.dart';
import 'package:vector_math/vector_math_64.dart' as vec;
import 'helper/constants.dart';

void main() {
  // 플랫폼 초기화
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey:navigatorKey,
      title: 'ginovo result',
      // onGenerateRoute: (routes)=>
      //     MaterialPageRoute(
      //     builder: (_)=>LongPutResultPage(
      //       points: [vec.Vector2(0, 0), vec.Vector2(20,300),],
      //       skidPoints: [vec.Vector2(0, 0), vec.Vector2(0,40),],
      //       greenSpeedTxt: '3.0',
      //       targetDistance: 300,
      //       hittingTimeTxt: '1.2s',
      //       initialSpeedTxt: '1.7m/s',
      //       hittingAmountTxt: '0.04N',
      //       spinAxisAngle: -20,
      //       spinRPM: 1200,
      //       hittingPos: Offset(-40, 10),
      //       spinType:  SpinType.top,
      //       putterLRAngle: 20.0,
      //       putterTBAngle: 15.0,
      //       gapDistanceTxt: "R 0.2m",
      //       puttingDistanceTxt: "3.1m",
      //       skidDistanceTxt: "0.2m",
      //       launchAngleTxt: "R 3.0°",
      //     )
      // ),
      //   onGenerateRoute: (routes)=>MaterialPageRoute(
      //       builder: (_)=>MatResultPage(
      //         points: [vec.Vector2(0, 0), vec.Vector2(20,300),],
      //         skidPoints: [vec.Vector2(0, 0), vec.Vector2(0,40),],
      //         greenSpeedTxt: '3.0',
      //         startPoint: StartPoint.b,
      //         endPoint: EndPoint.A,
      //         pathTxt: "b -> A",
      //         hittingTimeTxt: '1.2s',
      //         initialSpeedTxt: '1.7m/s',
      //         hittingAmountTxt: '0.04N',
      //         spinAxisAngle: -20,
      //         spinRPM: 1200,
      //         hittingPos: Offset(-40, 10),
      //         spinType:  SpinType.top,
      //         putterLRAngle: 20.0,
      //         putterTBAngle: 15.0,
      //         gapDistanceTxt: "R 0.2m",
      //         puttingDistanceTxt: "3.1m",
      //         skidDistanceTxt: "0.2m",
      //         launchAngleTxt: "R 3.0°",
      //       )
      //   ),
      //   onGenerateRoute: (routes)=>
      //       MaterialPageRoute(
      //           builder: (_)=>HomePage(),
      //       ),
        onGenerateRoute: (routes)=>
            MaterialPageRoute(
              builder: (_)=>HistoryPage(),
            ),
        builder:(ctx,widget) {
          ScreenUtil.init(ctx, designSize: Size(AppSize.standardWidth, AppSize.standardHeight));
          return widget!;
        }
    );
  }
}




