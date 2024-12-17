# ginovo_result

A new Flutter project.

## 폴더 구조
```bash
.
├── assets/
│   ├── image/
│   │   ├── ball_img.png   [골프공 이미지] 
│   │   ├── ball_img_with_padding.png   [패팅 있는 골프공 이미지]
│   │   ├── long_put_rail.png   [골프 깃대 이미지]
│   │   ├── mat_90_grey.png   [회색 90cm 골프 매트  1084 x 4096]
│   │   ├── mat_90_grey_x2.png   [회색 90cm 골프 매트  2168 x 8192]
│   │   ├── putter_side.png   [퍼터 측면 이미지]
│   │   ├── putter_top.png   [퍼터 상단 이미지]
│   │   ├── putting_img1.jpg   [골프장 예시 이미지 1]
│   │   └── putting_img2.jpg   [골프장 예시 이미지 2]
│   └── web/
│       ├── 3d_viewer.html   [골프공 회전 시뮬레이션 html]
│       └── ball.glb   [골프공 3d 모델 파일]
└── lib/
    ├── helper   [유틸 클래스 모음 폴더]/
    │   ├── constaints.dart   [디자인된 앱(figma) 사이즈 선언 클래스]
    │   ├── long_put_calculator.dart   [롱펏 수치 계산 클래스]
    │   └── mat_calculator.dart   [매트 수치 계산 클래스]
    ├── presentation   [화면단 폴더]/
    │   ├── pages/
    │   │   ├── long_put_result_page.dart   [롱펏 결과 화면 페이지]
    │   │   └── mat_result_page.dart   [매트 결과 화면 페이지]
    │   └── widgets/
    │       ├── dashed_line.dart   [점선 위젯]
    │       ├── data_panel.dart   [데이터 수치 패널 위젯]
    │       ├── growing_dashed_line.dart   [애니메이션 적용된 점선 위젯]
    │       ├── hitted_dot.dart   [타점 위젯]
    │       ├── long_put_panel.dart   [롱펏 결과 그래픽 패널 위젯 (화면 중 상단 위치)]
    │       ├── mat_panel.dart   [매트 결과 그래픽 패널 위젯 (화면 중 상단 위치)]
    │       ├── putter_panel.dart   [퍼터 결과 그래픽 패널 위젯 (화면 중 최하단 위치)]
    │       ├── rotation_panel.dart   [퍼터 결과 그래픽 패널 위젯 (화면 중 중간 위치)]
    │       └── web_3d_viewer.dart   [3d 회전 시뮬레이션 html을 InAppWebView로 보여주는 위젯]
    └── main.dart   [앱 시작 파일]
```


## 추가 라이브러리


```yaml
  flutter_screenutil: ^5.9.3   # 반응형 위젯 라이브러리
  vector_math: ^2.1.4   # 백터 라이브러리
  flutter_inappwebview: ^6.1.5   # 웹뷰 라이브러리
```


***


## 환경설정

1. 반응형 디자인을 적용하기 위해 screenUtil init 해준다.


lib/main.dart
```dart 
MaterialApp(
     ...
        builder:(ctx,widget) {
          ScreenUtil.init(ctx, designSize: Size(AppSize.standardWidth, AppSize.standardHeight));
          return widget!;
        }
    );
```

AppSize는 lib/helper/constaints.dart 파일에
AppSize 클래스가 정의되어 있다. (수치 변경 안해야 함. figma로 디자인한 사이즈 정의)



2. assets 폴더를 pubspec.yaml 파일에 경로 참조를 해준다.

pubspec.yaml
```yaml
  assets:
     - assets/image/
     - assets/web/
```


***





