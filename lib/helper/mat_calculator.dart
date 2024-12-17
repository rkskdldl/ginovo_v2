import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vector_math/vector_math_64.dart';


abstract class MatCalculatorInterface{
  /*
  * 매트 이미지 좌측 아래 좌표를 (0,0)으로 했을때,  flutter 좌표로 변환 해서 알려주는 함수
  * parameter : StartPoint 는 매트 시작점, movedData는 공이 실재로 이동한 거리(cm) (x좌표,y좌표)
  * */
  // 매트 이미지 좌측 아래 좌표를 (0,0)으로 했을때
  Vector2 calculatePos({required StartPoint sp, required Vector2 movedData});

  //포인트 배열 변환
  List<Vector2> translatePoints({required StartPoint sp,required List<Vector2> points});

  Vector2 getStartPoint({required StartPoint sp});
  Vector2 getEndPoint({required EndPoint ep});
}

class MatCalculator implements MatCalculatorInterface{
  static MatCalculator instance =  MatCalculator();

  static const double originWidth = 1084;
  static const double originHeight = 4096;

  static const double convertWidth = 132;
  static const double convertHeight = convertWidth *(originHeight/originWidth);
  // static const double convertHeight = 499;
  //3.4m 기준
  static double widthBias = convertWidth/originWidth;
  static double heightBias = convertHeight/originHeight;
  static double cmHBias = convertHeight/340;
  static double cmWBias = convertWidth/90;
  // 10cm에 15.5
  static Vector2 aPosSmall = Vector2(178 * widthBias, 3855*heightBias);
  static Vector2 bPosSmall = Vector2(542 * widthBias,3855*heightBias);
  static Vector2 cPosSmall = Vector2(903 * widthBias,3855*heightBias);

  static Vector2 lPosMiddle = Vector2(238 * widthBias, 2062*heightBias);
  static Vector2 mPosMiddle = Vector2(542 * widthBias,2062*heightBias);
  static Vector2 rPosMiddle = Vector2(846 * widthBias,2062*heightBias);

  static Vector2 aPosBig = Vector2(178 * widthBias, 269*heightBias);
  static Vector2 bPosBig = Vector2(542 * widthBias,269*heightBias);
  static Vector2 cPosBig = Vector2(903 * widthBias,269*heightBias);


  @override
  Vector2 calculatePos({required StartPoint sp, required Vector2 movedData}){
    Vector2 startVector = Vector2(0, 0);

    switch(sp){
      case StartPoint.a:
        startVector = aPosSmall;
        break;
      case StartPoint.b:
        startVector = bPosSmall;
        break;
      case StartPoint.c:
        startVector = cPosSmall;
        break;
      case StartPoint.A:
        startVector = aPosBig;
        break;
      case StartPoint.B:
        startVector = bPosBig;
        break;
      case StartPoint.C:
        startVector = cPosBig;
        break;
      case StartPoint.L:
        startVector = lPosMiddle;
        break;
      case StartPoint.M:
        startVector = mPosMiddle;
        break;
      case StartPoint.R:
        startVector = rPosMiddle;
        break;
    }

    Vector2 transVector = Vector2((startVector.x+(movedData.x * cmWBias)),(startVector.y-(movedData.y * cmHBias)));
    return Vector2(transVector.x.w, transVector.y.w);
  }

  @override
  List<Vector2> translatePoints({required StartPoint sp,required List<Vector2> points}) {
    //  List<Offset> oList = generateCurvePoints(startPoint: Offset(points.first.x, points.first.y), endPoint:  Offset(points.last.x, points.last.y), isRight: true,curvature: 0.4);
    //  List<Vector2> psList = [points.first,...oList.map((e)=>Vector2(e.dx, e.dy)),points.last];
    // return  psList.map((e)=>calculatePos(sp: sp, movedData: e)).toList();
    return points.map((e)=>calculatePos(sp: sp, movedData: e)).toList();
  }

  @override
  Vector2 getEndPoint({required EndPoint ep}) {
    Vector2 endVector = Vector2(0,0);
    switch(ep){
      case EndPoint.a:
        endVector = aPosSmall;
        break;
      case EndPoint.b:
        endVector = bPosSmall;
        break;
      case EndPoint.c:
        endVector = cPosSmall;
        break;
      case EndPoint.A:
        endVector = aPosBig;
        break;
      case EndPoint.B:
        endVector = bPosBig;
        break;
      case EndPoint.C:
        endVector = cPosBig;
        break;
      case EndPoint.L:
        endVector = lPosMiddle;
        break;
      case EndPoint.M:
        endVector = mPosMiddle;
        break;
      case EndPoint.R:
        endVector = rPosMiddle;
        break;
    }

    return Vector2(endVector.x.w, endVector.y.w);
  }

  @override
  Vector2 getStartPoint({required StartPoint sp}) {
    Vector2 startVector = Vector2(0, 0);
    switch(sp){
      case StartPoint.a:
        startVector = aPosSmall;
        break;
      case StartPoint.b:
        startVector = bPosSmall;
        break;
      case StartPoint.c:
        startVector = cPosSmall;
        break;
      case StartPoint.A:
        startVector = aPosBig;
        break;
      case StartPoint.B:
        startVector = bPosBig;
        break;
      case StartPoint.C:
        startVector = cPosBig;
        break;
      case StartPoint.L:
        startVector = lPosMiddle;
        break;
      case StartPoint.M:
        startVector = mPosMiddle;
        break;
      case StartPoint.R:
        startVector = rPosMiddle;
        break;
    }
    return Vector2(startVector.x.w,startVector.y.w);
  }
  /// 시작점과 끝점을 기반으로 여러 포인트를 계산하여 곡선을 만드는 함수
  List<Vector2> generateCurvePoints({
    required Vector2 startPoint,
    required Vector2 endPoint,
    required bool isRight, // true: 오른쪽으로 휘게, false: 왼쪽으로 휘게
    double curvature = 0.3, // 곡률 정도 (0.0 ~ 1.0)
    int pointCount = 100, // 생성할 포인트 개수
  }) {
    final points = <Vector2>[];

    // 두 점의 중간점 계산
    final midPoint = Offset(
      (startPoint.x + endPoint.x) / 2,
      (startPoint.y + endPoint.y) / 2,
    );

    // 두 점의 기울기 벡터 계산
    final vector = Offset(
      endPoint.y - startPoint.y,
      -(endPoint.x - startPoint.x),
    );

    // 벡터를 정규화하여 방향만 유지
    final normalizedVector = Offset(
      vector.dx / vector.distance,
      vector.dy / vector.distance,
    );

    // 곡률에 따라 벡터를 스케일링
    final scaledVector = Offset(
      normalizedVector.dx * curvature * 100,
      normalizedVector.dy * curvature * 100,
    );

    // 제어점 계산
    final controlPoint = Offset(
      midPoint.dx + (isRight ? scaledVector.dx : -scaledVector.dx),
      midPoint.dy + (isRight ? scaledVector.dy : -scaledVector.dy),
    );

    // 곡선 포인트 계산 (Quadratic Bezier Curve)
    for (int i = 0; i <= pointCount; i++) {
      final t = i / pointCount; // 비율 (0.0 ~ 1.0)

      // Bezier 공식: (1-t)^2 * P0 + 2(1-t)t * P1 + t^2 * P2
      final x = (1 - t) * (1 - t) * startPoint.x +
          2 * (1 - t) * t * controlPoint.dx +
          t * t * endPoint.x;

      final y = (1 - t) * (1 - t) * startPoint.y +
          2 * (1 - t) * t * controlPoint.dy +
          t * t * endPoint.y;

      points.add(Vector2(x, y));
    }

    return points;
  }

}


enum StartPoint{
  a,
  b,
  c,
  A,
  B,
  C,
  L,
  M,
  R
}

enum EndPoint{
  a,
  b,
  c,
  A,
  B,
  C,
  L,
  M,
  R
}
