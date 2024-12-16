import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/presentation/pages/long_put_result_page.dart';
import 'package:ginovo_result/presentation/pages/mat_result_page.dart';
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
      onGenerateRoute: (routes)=>MaterialPageRoute(builder: (_)=>LongPutResultPage()),
        builder:(ctx,widget) {
          ScreenUtil.init(ctx,
              designSize: Size(AppSize.standardWidth, AppSize.standardHeight));
          return widget!;
        }
    );
  }
}




