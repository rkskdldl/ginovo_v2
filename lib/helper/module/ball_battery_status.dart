class BallBatteryStatus {
  String value = "";
  DateTime timestamp = DateTime.now();

  BallBatteryStatus(String message, this.timestamp) {
    (message.contains("DisConnect"))
        ? value = message
        : value = getBatteryValue(message);
  }

  String getBatteryValue(String message) {
    String key = "";
    String value = "";

    RegExp regExp = RegExp(r'{"(.*?)":"(.*?)"}'); // 정규식 패턴
    Match? match = regExp.firstMatch(message); // 패턴 매칭

    if (match != null && match.groupCount == 2) {
      String key = match.group(1)!;
      String value = match.group(2)!;
      return value; // key-value 반환
    } else {
      print("유효한 형식이 아닙니다.");
      return "null";
    }
  }

  List<String> toList() {
    return [
      value.toString(),
      timestamp.toIso8601String(), // 날짜를 문자열로 변환
    ];
  }
}
