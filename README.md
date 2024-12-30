# ginovo_result

지노버 결과화면, 홈화면 퍼브리싱 코드

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




## 페이지 파라미터

### 결과 페이지 공통항목

| No. | 명칭         | 변수명              | 자료형           | 설명                                                                                                                            | 비고                                |
|-----|------------|------------------|---------------|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|
| 1   | 궤적 벡터 리스트  | points           | List<Vector2> | - List를 많이 넣을수록 궤적 선 표시가 부드럽게 보임  - 시작점이 0,0 원점이 되고 시작점 기준 cm 단위로 값을 넣으면 됨 - x 값은 오른쪽은 양수, 왼쪽은 음수 / y 값은 위쪽 방향이 양수 아래쪽 방향이 음수 | [Vector2(0,0), Vector2(0,300)]    |
| 2   | 스키드 벡터 리스트 | skidPoints       | List<Vector2> | - 스키드 부분 백터 리스트만 넣으면 됨                                                                                                        | [Vector2(0,0), Vector2(0,40)]     |
| 3   | 그린 스피드     | greenSpeedTxt    | string        |                                                                                                                               | ex) '3.0'                         |
| 4   | 타격시간       | hittingTimeTxt   | string        |                                                                                                                               | ex) '1.2s'                        |
| 5   | 초기속도       | initialSpeedTxt  | string        |                                                                                                                               | ex) '1.7m/s'                      |
| 6   | 충격량        | hittingAmountTxt | string        |                                                                                                                               | ex) '0.04N'                       |
| 7   | 공 회전축 각도   | spinAxisAngle    | double        | 수직 축이 0도이며 왼쪽으로 기울이면 음수, 오른쪽으로 기울이면 양수                                                                                        | ex) -20.0                         |
| 8   | 공 회전 RPM   | spinRPM          | int           |                                                                                                                               | ex) 1200                          |
| 9   | 타점 위치      | hittingPos       | Offset        | - 공의 중앙이 (0,0) 원점  - x: -50 ~ 50 / y: -50 ~ 50  지름을 100 기준                                                                    | ex) Offset( -40, 10)              |
| 10  | 스핀 유형      | spinType         | SpinType      | - 앞으로 구르기 (Top) , 뒤로 구르기 (Back)                                                                                               | ex) SpinType.top  , SpinType.back |
| 11  | 퍼터 좌우각도    | putterLRAngle    | double        |                                                                                                                               | ex) 20.0                          |
| 12  | 퍼터 상하각도    | putterTBAngle    | double        |                                                                                                                               | ex) 15.0                          |


### 롱펏 결과

| No. | 명칭         | 변수명              | 자료형           | 설명                                                                                                                            | 비고                                |
|-----|------------|------------------|---------------|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|
| 1   | 목표거리  | targetDistance           | double | - cm 단위 | ex) [Vector2(0,0), Vector2(0,300)]    |


### 매트 결과

| No. | 명칭         | 변수명              | 자료형           | 설명                                                                                                                            | 비고                                |
|-----|------------|------------------|---------------|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|
| 1   | 시작점  | startPoint           | StartPoint |  | ex) StartPoint.a, StartPoint.b, StartPoint.c, StartPoint.A, StartPoint.B, StartPoint.C, StartPoint.L, StartPoint.M, StartPoint.R  |
| 2   | 종료점  | endPoint           | EndPoint |  | ex) EndPoint.a, EndPoint.b, EndPoint.c, EndPoint.A, EndPoint.B, EndPoint.C, EndPoint.L, EndPoint.M, EndPoint.R  |
| 3   | 경로명  | pathTxt           | string |  | ex) 'b -> A'    |


### 홈
#### short_cut_button_panel.dart
바로가기 버튼 패널

| No. | 명칭         | 변수명              | 자료형           | 설명                                                                                                                            | 비고                                |
|-----|------------|------------------|---------------|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|
| 1   | 매트모드 실행함수  | matModeOnClick         | Function |  |  |
| 2   | 자유모드 실행함수  | freeModeOnClick           | Function |  | |
| 3   | 롱펏모드 실행함수  | longPuttOnClick           | Function |  | |


#### hitting_spin_panel.dart
타점 & 스핀 패널

| No. | 명칭         | 변수명              | 자료형           | 설명                                                                                                                            | 비고                                |
|-----|------------|------------------|---------------|-------------------------------------------------------------------------------------------------------------------------------|-----------------------------------|
| 1   | 타점 리스트  |          | Function |  |  |
| 2   | 회전 각도 리스트  | freeModeOnClick           | Function |  | |
| 3   | 메인 회전 각도  | longPuttOnClick           | Function |  | |
| 4   | 메인 회전 각도 빈도  | matModeOnClick         | Function |  |  |
| 5   | 타점 포인트 | freeModeOnClick           | Function |  | |
| 6   | 타점 포인트 빈도  | longPuttOnClick           | Function |  | |

