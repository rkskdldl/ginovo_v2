
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/helper/mat_calculator.dart';
import 'package:vector_math/vector_math_64.dart';

abstract class FreeCalculatorInterface{
  //포인트 배열 변환
  List<Vector2> translatePoints({required double height,required double width,required List<Vector2> points});
  Vector2 calculatePos({ required double height,required double width, required Vector2 movedData});

}


class FreeCalculator implements FreeCalculatorInterface{
  static FreeCalculator instance =  FreeCalculator();

  static double convertWidth = 132;
  // static double convertHeight = MatCalculator.convertHeight- 44.w;
  static double convertHeight = 400;

  @override
  Vector2 calculatePos({required double height, required double width, required Vector2 movedData}) {
    Vector2 transVector = Vector2((convertWidth/2) + movedData.x * (convertWidth/width),convertHeight - (movedData.y*(convertHeight/height)));
    return Vector2(transVector.x.w, transVector.y.w);
  }

  @override
  List<Vector2> translatePoints({required double height, required double width, required List<Vector2> points}) {
    return points.map((e)=>calculatePos(height: height, width: width, movedData: e)).toList();
  }







}