import 'dart:io';
import 'package:csv/csv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math_64.dart';

class CsvHelper {
  Future<void> saveToCsv(List<double> w, List<double> x, List<double> y,
      List<double> z, List<DateTime> timestamp) async {
    // 데이터 검증
    if (w.length != x.length || w.length != y.length || w.length != z.length) {
      throw Exception("pitch, yaw, roll 데이터의 길이가 같아야 합니다.");
    }

    // CSV 데이터 생성
    List<List<dynamic>> rows = [
      ["w", "x", "y", "z", "timestamp"] // 헤더 추가
    ];

    for (int i = 0; i < w.length; i++) {
      rows.add([w[i], x[i], y[i], z[i], timestamp[i].millisecondsSinceEpoch]);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    // 파일 저장
    final directory = await getExternalStorageDirectory();
    final path =
        "${directory?.path}/data_${DateTime.now().millisecondsSinceEpoch}.csv";
    final file = File(path);

    await file.writeAsString(csvData);

    print("CSV 파일이 저장되었습니다: $path");
  }

  Future<void> saveToCsvAngle(List<double> w, List<double> x, List<double> y,
      List<double> z, List<DateTime> timestamp) async {
    // 데이터 검증
    if (w.length != x.length || w.length != y.length || w.length != z.length) {
      throw Exception("pitch, yaw, roll 데이터의 길이가 같아야 합니다.");
    }

    // CSV 데이터 생성
    List<List<dynamic>> rows = [
      ["x", "y", "z", "timestamp"] // 헤더 추가
    ];

    for (int i = 0; i < w.length; i++) {
      rows.add([w[i], x[i], y[i], timestamp[i].millisecondsSinceEpoch]);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    // 파일 저장
    final directory = await getExternalStorageDirectory();
    final path =
        "${directory?.path}/data_${DateTime.now().millisecondsSinceEpoch}.csv";
    final file = File(path);

    await file.writeAsString(csvData);

    print("CSV 파일이 저장되었습니다: $path");
  }

  Future<void> saveVectorsToCsv(
      List<Vector3> vectors, List<DateTime> timestamp) async {
    // 데이터 검증
    // if (w.length != x.length || w.length != y.length || w.length != z.length) {
    //   throw Exception("pitch, yaw, roll 데이터의 길이가 같아야 합니다.");
    // }

    // CSV 데이터 생성
    List<List<dynamic>> rows = [
      ["x", "y", "z", "timestamp"] // 헤더 추가
    ];

    for (int i = 0; i < vectors.length; i++) {
      rows.add([
        vectors[i].x,
        vectors[i].y,
        vectors[i].z,
        timestamp[i].millisecondsSinceEpoch
      ]);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    // 파일 저장
    final directory = await getExternalStorageDirectory();
    final path =
        "${directory?.path}/vector_${DateTime.now().millisecondsSinceEpoch}.csv";
    final file = File(path);

    await file.writeAsString(csvData);
    Fluttertoast.showToast(msg: "파일이 저장되었습니다.");
    print("CSV 파일이 저장되었습니다: $path");
  }

  Future<void> saveBatteryStatus(
      List<String> value, List<DateTime> timestamp, String deviceName) async {
    // 데이터 검증
    if (value.length != timestamp.length) {
      throw Exception("데이터의 길이가 같아야 합니다.");
    }

    // CSV 데이터 생성
    List<List<dynamic>> rows = [
      ["timestamp(KST)", "value(%)"] // 헤더 추가
    ];

    for (int i = 0; i < value.length; i++) {
      rows.add([timestamp[i], value[i]]);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    // 파일 저장
    final directory = await getExternalStorageDirectory();
    String path = "";
    List<String> folders = directory!.path.split("/");
    for (int i = 1; i < folders.length; i++) {
      String folder = folders[i];
      if (folder != "Android") {
        path += "/$folder";
      } else {
        break;
      }
    }
    path += "/Documents";

    final newpath =
        "${path}/BatteryStatusData_${deviceName}_${DateTime.now().millisecondsSinceEpoch}.csv";
    final file = File(newpath);

    await file.writeAsString(csvData);

    print("CSV 파일이 저장되었습니다: $path");
  }
}
