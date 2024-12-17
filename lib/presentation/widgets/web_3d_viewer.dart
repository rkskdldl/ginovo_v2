import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

enum SpinType{
  top,
  back,
}

class Web3dViewer extends StatefulWidget {
  const Web3dViewer({super.key,required this.spinAngle,required this.spinType});
  final double spinAngle;
  final SpinType spinType;
  @override
  State<Web3dViewer> createState() => _Web3dViewerState();
}

class _Web3dViewerState extends State<Web3dViewer> {

  late InAppWebViewController webViewController;
  String? ballData;
  @override
  void initState() {

    DefaultAssetBundle.of(context).loadString('assets/web/3d_viewer.html').then((e){

    });
    DefaultAssetBundle.of(context).load('assets/web/ball.glb').then((ball){
     setState(() {
       ballData =  base64Encode(ball.buffer.asUint8List());
     });

    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ballData!=null?Container(
        child: InAppWebView(
          initialSettings: InAppWebViewSettings(
            allowFileAccessFromFileURLs: true,
            allowUniversalAccessFromFileURLs: true,
            hardwareAcceleration: true,
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;

            // 로컬 파일 경로를 JavaScript로 전달
            controller.evaluateJavascript(source: """
             window.addEventListener("load", function(event) {
             const base64String = '${ballData}';
          const binaryData = atob(base64String); // Base64 디코딩
          const arrayBuffer = new Uint8Array(binaryData.length);
          for (let i = 0; i < binaryData.length; i++) {
            arrayBuffer[i] = binaryData.charCodeAt(i);
          }

          const blob = new Blob([arrayBuffer], { type: 'model/gltf-binary' });
          const url = URL.createObjectURL(blob);
       const glbPath = url;
            console.log("GLB Path: ", glbPath);
             
    loader.load(
      url, // 여기에 실제 .glb 파일 경로를 입력하세요
      (gltf) => {
        const model = gltf.scene;
        scene.add(model);
         // 모델 크기 조정
        model.scale.set(1, 1, 1);  // 필요에 맞게 크기 조정

    // 카메라 위치 설정
    camera.position.z = 2;
        console.log('모델 로드 성공:', gltf);
         camera.rotation.z = ${(widget.spinAngle-270) * pi /180};
        
        
            // 애니메이션 루프
        function animate() {
          requestAnimationFrame(animate);
       // 모델 회전
         model.rotation.x += ${0.01*(widget.spinType==SpinType.top?-1:1)}; //x축 회전
          renderer.render(scene, camera);
        }
    animate();
      },
      undefined,
      (error) => {
        console.error('모델 로드 에러:', error);
      }
    );

  });
         
          """);
          },
          initialFile: 'assets/web/3d_viewer.html',
        ),
      ):Container(),
    );
  }
}
