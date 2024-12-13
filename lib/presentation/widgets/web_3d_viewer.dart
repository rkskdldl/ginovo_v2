import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class Web3dViewer extends StatefulWidget {
  const Web3dViewer({super.key});

  @override
  State<Web3dViewer> createState() => _Web3dViewerState();
}

class _Web3dViewerState extends State<Web3dViewer> {

  late InAppWebViewController webViewController;
  @override
  void initState() {

    DefaultAssetBundle.of(context).loadString('assets/3d_viewer.html').then((e){

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: InAppWebView(
          initialSettings: InAppWebViewSettings(
            allowFileAccessFromFileURLs: true,
            allowUniversalAccessFromFileURLs: true,
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;

            // 로컬 파일 경로를 JavaScript로 전달
            controller.evaluateJavascript(source: """
            const glbPath = '${Uri.file("assets/web/ball.glb").toString()}';
            console.log("GLB Path: ", glbPath);
          """);
          },
          initialFile: 'assets/web/3d_viewer.html',
        ),
      ),
    );
  }
}
