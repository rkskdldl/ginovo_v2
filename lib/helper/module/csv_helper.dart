import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

class CsvHelper {
  Future<void> saveToCsv(List<double> w,List<double> x,List<double> y,List<double> z, List<DateTime> timestamp) async {
    // 데이터 검증
    if (w.length != x.length || w.length != y.length || w.length != z.length) {
      throw Exception("pitch, yaw, roll 데이터의 길이가 같아야 합니다.");
    }

    // CSV 데이터 생성
    List<List<dynamic>> rows = [
      ["w", "x", "y", "z","timestamp"] // 헤더 추가
    ];

    for (int i = 0; i < w.length; i++) {
      rows.add([w[i], x[i], y[i],z[i],timestamp[i].millisecondsSinceEpoch]);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    // 파일 저장
    final directory = await getExternalStorageDirectory();
    final path = "${directory?.path}/data_${DateTime.now().millisecondsSinceEpoch}.csv";
    final file = File(path);

    await file.writeAsString(csvData);

    print("CSV 파일이 저장되었습니다: $path");
  }
}
