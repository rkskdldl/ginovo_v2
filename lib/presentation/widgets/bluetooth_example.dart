import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:ginovo_result/helper/module/ball_data_manager.dart';
import 'package:ginovo_result/helper/module/csv_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vector_math/vector_math_64.dart';

import 'direction_painter.dart';

class BluetoothExample extends StatefulWidget {
  @override
  _BluetoothExampleState createState() => _BluetoothExampleState();
}

class _BluetoothExampleState extends State<BluetoothExample> {
  final String targetDeviceName = "GINOVO"; // 연결할 장치 이름
  BluetoothDevice? targetDevice;
  List<BluetoothCharacteristic> characteristicList = [];
  BluetoothCharacteristic? targetCharacteristic;

  List<String> receivedMessages = ["wait"]; // 수신된 메시지 리스트
  Vector? relativeVector;
  @override
  void initState() {
    super.initState();
    requestStoragePermission().then((e){
    startScan();
    });
  }

  void startScan() async {
    FlutterBluePlus.startScan(timeout: Duration(seconds: 10));

    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        print("장치 발견: ${result.device.advName}, RSSI: ${result.rssi}");
        if (result.device.advName.contains(targetDeviceName)) {
          print("목표 장치 발견: ${result.device.name}");
          setState(() {
            targetDevice = result.device;
          });
          FlutterBluePlus.stopScan();
          connectToDevice();
          break;
        }
      }
    });
  }

  void connectToDevice() async {
    if (targetDevice == null) return;

    await targetDevice!.connect();
    print("장치 연결됨: ${targetDevice!.advName}");
// 연결 후 대기
    await Future.delayed(Duration(seconds: 2));
    targetDevice!.state.listen((state) async{
      if (state == BluetoothConnectionState.connected) {
        print("장치 연결 상태: 연결됨");
    // 장치의 서비스 탐색
    List<BluetoothService> services = await targetDevice!.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        // 원하는 characteristic UUID를 확인하여 저장
        if (characteristic.properties.write) {
          print("송신 characteristic 발견: ${characteristic.uuid}");
          setState(() {
            characteristicList.add(characteristic);
            targetCharacteristic = characteristic;
          });
        }
        if (characteristic.properties.notify) {
          print("수신 characteristic 발견: ${characteristic.uuid}");
          enableNotification(characteristic);
        }
      }
    }
      } else {
        print("장치 연결 상태: 연결되지 않음");
      }
    });
  }
  void enableNotification(BluetoothCharacteristic characteristic) async {
    await characteristic.setNotifyValue(true);
    characteristic.onValueReceived.listen((value) {
      // 바이트 배열을 문자열로 변환
      String message = String.fromCharCodes(value);
      if(!message.contains("ready")) {
        // print("수신된 메시지: $message");

        List<double> datas = BallDataManager.instance.translateData(message);
        BallDataManager.wList.add(datas[0]);
        BallDataManager.xList.add(datas[1]);
        BallDataManager.yList.add(datas[2]);
        BallDataManager.zList.add(datas[3]);
        BallDataManager.timestamp.add(DateTime.now());

        setState(() {
          receivedMessages.add(message);// 수신된 메시지를 리스트에 추가
        });
      }
    });
    print("알림 활성화: ${characteristic.uuid}");
  }
  void sendMessage(BluetoothCharacteristic? bleCharacteristic, String message) async {
    if (bleCharacteristic == null) return;

    List<int> bytes = message.codeUnits; // 문자열을 바이트로 변환
    await bleCharacteristic!.write(bytes);
    print("메시지 전송: $message");
  }
  Future<void> requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      print("저장소 권한 허용됨");
    } else {
      print("저장소 권한이 필요합니다.");
    }
  }
  @override
  void dispose() {
    targetDevice?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth 통신 예제'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              targetDevice == null
                  ? '스캔 중...'
                  : '연결된 장치: ${targetDevice!.advName}',
            ),
            SizedBox(height: 20),
           ElevatedButton(
                onPressed: (){
                  if(targetDevice != null){
                    sendMessage(characteristicList[1],'{"cmd":"raw"}');
                  }
                },
                child: Text('메시지 전송'),
              ),
            SizedBox(height: 20),
            Text(
              '수신된 메시지:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text("${receivedMessages.last}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()async{
                final csvHelper = CsvHelper();
                await csvHelper.saveToCsv(
                  BallDataManager.wList,
                  BallDataManager.xList,
                  BallDataManager.yList,
                  BallDataManager.zList,
                  BallDataManager.timestamp,
                );
              },
              child: Text('csv 저장'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
