import 'dart:math';

import 'package:vector_math/vector_math_64.dart';

class RotationTracker {
  double totalYawChange = 0.0; // yaw의 총 변화량
  double totalPitchChange = 0.0; // pitch의 총 변화량
  double totalRollChange = 0.0; // roll의 총 변화량

  // 마지막 쿼터니언을 저장하여 변화량을 계산합니다.
  Quaternion lastQuaternion = Quaternion(1.0, 0.0, 0.0, 0.0);

  // 회전 변화량을 추적하고 한 바퀴 돌았는지 확인하는 함수
  bool checkFullRotation(Quaternion currentQuaternion) {
    lastQuaternion.conjugate();
    // 쿼터니언 간의 변화량을 구합니다.
    Quaternion delta = currentQuaternion * lastQuaternion;

    // delta 쿼터니언을 오일러 각으로 변환합니다.
    Vector3 eulerAngles = delta.toEulerAngles();

    // 각도 변화량을 누적합니다.
    totalYawChange += eulerAngles.x;
    totalPitchChange += eulerAngles.y;
    totalRollChange += eulerAngles.z;

    // 한 바퀴(360도)를 넘었는지 확인합니다.
    bool isFullRotation = (totalYawChange.abs() >= 360.0) ||
        (totalPitchChange.abs() >= 360.0) ||
        (totalRollChange.abs() >= 360.0);

    // 마지막 쿼터니언을 갱신하여 현재 회전 상태를 기록합니다.
    lastQuaternion = currentQuaternion;

    return isFullRotation;
  }
}
extension Euler on Quaternion{
  // 쿼터니언을 오일러 각도로 변환하는 함수
  Vector3 toEulerAngles() {
    double roll, pitch, yaw;

    // Roll (x축 회전)
    double sinr_cosp = 2 * (w * x + y * z);
    double cosr_cosp = 1 - 2 * (x * x + y * y);
    roll = atan2(sinr_cosp, cosr_cosp);

    // Pitch (y축 회전)
    double sinp = 2 * (w * y - z * x);
    if (sinp >= 1) {
      pitch = pi / 2; // 90 degrees
    } else if (sinp <= -1) {
      pitch = -pi / 2; // -90 degrees
    } else {
      pitch = asin(sinp);
    }

    // Yaw (z축 회전)
    double siny_cosp = 2 * (w * z + x * y);
    double cosy_cosp = 1 - 2 * (y * y + z * z);
    yaw = atan2(siny_cosp, cosy_cosp);

    return Vector3(roll, pitch, yaw);
  }
  /// 상대 쿼터니언에서 회전축 및 회전 각도 계산
  Map<String, dynamic> toRotationAxisAndAngle() {
    double theta = 2 * acos(w); // 회전 각도
    double axisNorm = sqrt(x * x + y * y + z * z);

    // 회전 축 계산 (정규화)
    List<double> axis = axisNorm > 1e-6
        ? [x / axisNorm, y / axisNorm, z / axisNorm]
        : [0.0, 0.0, 0.0];

    return {'angle': theta, 'axis': axis};
  }
  /// 쿼터니언의 역수 계산
  Quaternion customInverse() {
    return Quaternion(w, -x, -y, -z);
  }

  /// 쿼터니언 곱셈
  Quaternion multiply(Quaternion other) {
    return Quaternion(
      w * other.w - x * other.x - y * other.y - z * other.z,
      w * other.x + x * other.w + y * other.z - z * other.y,
      w * other.y - x * other.z + y * other.w + z * other.x,
      w * other.z + x * other.y - y * other.x + z * other.w,
    );
  }
}

// 각도를 쿼터니언으로 변환하는 함수
Quaternion eulerToQuaternion(double pitch, double yaw, double roll) {
  double pitchRad = radians(pitch);
  double yawRad = radians(yaw);
  double rollRad = radians(roll);

  double qw = cos(yawRad / 2) * cos(pitchRad / 2) * cos(rollRad / 2) + sin(yawRad / 2) * sin(pitchRad / 2) * sin(rollRad / 2);
  double qx = sin(yawRad / 2) * cos(pitchRad / 2) * cos(rollRad / 2) - cos(yawRad / 2) * sin(pitchRad / 2) * sin(rollRad / 2);
  double qy = cos(yawRad / 2) * sin(pitchRad / 2) * cos(rollRad / 2) + sin(yawRad / 2) * cos(pitchRad / 2) * sin(rollRad / 2);
  double qz = cos(yawRad / 2) * cos(pitchRad / 2) * sin(rollRad / 2) - sin(yawRad / 2) * sin(pitchRad / 2) * cos(rollRad / 2);

  return Quaternion(qw, qx, qy, qz);
}
