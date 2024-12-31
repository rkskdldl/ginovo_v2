import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/presentation/widgets/data_panel.dart';
import 'package:ginovo_result/presentation/widgets/date_range_picker.dart';
import 'package:intl/intl.dart';

import '../../widgets/ball_speed_panel.dart';
import '../../widgets/face_angle_panel.dart';
import '../../widgets/hitting_spin_panel.dart';
import '../../widgets/putt_distance_panel.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9FB),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:24.w),
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: 24.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("History",
                    style: TextStyle(
                      fontSize:24.sp,
                      fontWeight: FontWeight.w500,

                    ),
                    ),
                  ),
                ),
                SizedBox(height:24.w),
                //페이지 토클 탭 영역
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6.w,horizontal: 8.w),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // 그림자 색상 및 투명도
                        spreadRadius: 2, // 그림자 크기 확장
                        blurRadius: 4, // 그림자 흐림 정도
                        offset: Offset(0, 4), // 그림자 위치 (x, y)
                      ),
                    ]
                  ),
                  child: LayoutBuilder(
                    builder: (ctx,constraint)=>IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _selectedIndex = 0 ;
                                });
                              },
                              child: Container(
                                decoration: _selectedIndex==0?BoxDecoration(
                                  color: Color(0xffd9d9d9),
                                  borderRadius: BorderRadius.circular(8.w),
                                ):null,
                                padding: EdgeInsets.symmetric(vertical: 2.w,horizontal: 6.w),
                                child: Center(
                                  child: Text(
                                    "Statistics",
                                    style: TextStyle(
                                      color: Color(0xff4c4c4c),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                            color: Color(0xffDDDDDD),
                            width:2.w,height: 20.w,),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _selectedIndex = 1;
                                  });
                                },
                                child: Container(
                                  decoration: _selectedIndex==1? BoxDecoration(
                                    color: Color(0xffd9d9d9),
                                    borderRadius: BorderRadius.circular(8.w),
                                  ):null,
                                  padding: EdgeInsets.symmetric(vertical: 2.w,horizontal: 6.w),
                                  child: Center(
                                    child: Text(
                                      "Record",
                                      style: TextStyle(
                                        color: Color(0xff4c4c4c),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                        ],
                      ),
                    ),
                  ),
                ),
                //페이지 바디 부분
                _selectedIndex==0?HistoryStatistics():HistoryRecord(),

              ],
            ),
          ),
      ),
    );
  }
}



class HistoryStatistics extends StatefulWidget {
  const HistoryStatistics({super.key});

  @override
  State<HistoryStatistics> createState() => _HistoryStatisticsState();
}

class _HistoryStatisticsState extends State<HistoryStatistics> {
  int selectedDataSetIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 40.w,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: DateRangePicker(datePickCallBack: (dates){

                  },),
                ),
                SizedBox(height: 30.w,),
                Text("Summary of Skills",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.w,),
                PanelContainer(
                  customPadding: EdgeInsets.symmetric(vertical: 30.w),
                  childWidget:   AspectRatio(
                    aspectRatio: 1.4,
                    child: Container(
                      child: RadarChart(
                        RadarChartData(
                          radarTouchData: RadarTouchData(
                            touchCallback: (FlTouchEvent event, response) {
                              if (!event.isInterestedForInteractions) {
                                setState(() {
                                  selectedDataSetIndex = -1;
                                });
                                return;
                              }
                              setState(() {
                                selectedDataSetIndex =
                                    response?.touchedSpot?.touchedDataSetIndex ?? -1;
                              });
                            },
                          ),
                          radarShape: RadarShape.polygon,
                          dataSets: showingDataSets(),
                          radarBackgroundColor: Colors.transparent,
                          borderData: FlBorderData(show: false, border: Border.all(color:  Color(0xff929292))),
                          radarBorderData: const BorderSide(color: Color(0xff929292)),
                          titlePositionPercentageOffset: 0.2,
                          titleTextStyle:
                          TextStyle(color: Color(0xff4C4C4C), fontSize: 12.sp,),
                          getTitle: (index, angle) {
                            double usedAngle =0;
                            switch (index) {
                              case 0:
                                return RadarChartTitle(
                                  text: 'Straightness',
                                  angle: usedAngle,
                                );
                              case 1:
                                return RadarChartTitle(
                                  text: 'Distance\nPerception',
                                  angle: usedAngle,
                                );
                              case 2:
                                return RadarChartTitle(
                                  text: 'Skid',
                                  angle: usedAngle,
                                );
                              case 3:
                                return RadarChartTitle(
                                  text: 'Impact\nTime',
                                  angle: usedAngle,
                                );
                              case 4:
                                return RadarChartTitle(
                                  text: 'Spin\nDirection',
                                  angle: usedAngle,
                                );
                              default:
                                return const RadarChartTitle(text: '');
                            }
                          },
                          tickCount: 3,
                          ticksTextStyle:
                          const TextStyle(color: Colors.transparent, fontSize: 10),
                          tickBorderData: const BorderSide(color: Color(0xffCFCFCF)),
                          gridBorderData: BorderSide(color:  Color(0xffCFCFCF), width: 1),
                        ),
                        duration: const Duration(milliseconds: 400),
                      ),
                    ),
                  ),)
              ],
            ),
          ),
          SizedBox(height: 40.w,),
          Container(
            width: double.maxFinite,
            height: 4.w,
            color: Color(0xffEAEAEA),
          ),
          SizedBox(height: 40.w,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HittingSpinPanel(
                  hittingPoints: [
                    Offset(0, 0),
                    Offset(0, 0),
                    Offset(10, 10),
                    Offset(20, 20),
                    Offset(10, 10),
                    Offset(30, 30),
                    Offset(10, 10),
                    Offset(20, 20),
                    Offset(20, 20),
                    Offset(20, 20),
                    Offset(40,0),
                    Offset(40,0),
                    Offset(40,0),
                    Offset(50,0),
                    Offset(0,50),
                    Offset(-50,0),
                  ],
                  angles: [0,15,30,45,60,75,90,-15,-30,-45,-60,-75,-90],
                  mostAngle: 10,
                  mostAnglePercent: 40,
                  mostHittingPoint: Offset(15,30),
                  mostHittingPercent: 60,
                ),
                SizedBox(height: 30.w,),
                PuttDistancePanel(data: [
                  DistanceBarElementModel(realDistance: 0.98,baseDistance: 1, index: 0,),
                  DistanceBarElementModel(realDistance: 2.2,baseDistance: 2, index: 1,),
                  DistanceBarElementModel(realDistance: 2.7,baseDistance: 3, index: 2,),
                  DistanceBarElementModel(realDistance: 6,baseDistance: 4, index: 3,),
                ],),
                SizedBox(height: 30.w,),
                BallSpeedPanel(
                  greenSpeedCallBack: (greenSpeed){},
                  data: [
                    SpeedBarElementModel(realSpeed: 0.6, baseSpeed: 0.8, targetDistance:1, index: 0),
                    SpeedBarElementModel(realSpeed: 1.6, baseSpeed: 1.4, targetDistance:2, index: 1),
                    SpeedBarElementModel(realSpeed: 1.9, baseSpeed: 2.2, targetDistance:3, index: 2),
                    SpeedBarElementModel(realSpeed: 3.2, baseSpeed: 2.9, targetDistance:5, index: 3),
                    SpeedBarElementModel(realSpeed: 0.6, baseSpeed: 3.2, targetDistance:1, index: 4),
                    SpeedBarElementModel(realSpeed: 1.6, baseSpeed: 3.8, targetDistance:2, index: 5),
                    SpeedBarElementModel(realSpeed: 1.9, baseSpeed: 4.1, targetDistance:3, index: 6),
                    SpeedBarElementModel(realSpeed: 3.2, baseSpeed: 4.9, targetDistance:5, index: 7),
                  ],),
                SizedBox(height: 30.w,),
                FaceAnglePanel(
                  mostTopAngle:  12,
                  mostTopPercent: 40,
                  topAngles: [0,30,0,60,90],
                  mostSideAngle: 30,
                  mostSidePercent: 45,
                  sideAngles: [0,30,45,45,45,45,45,45,45,46,46,46,47,47,47,48,48,48,44,44,44,44,43,43,43,42,42,41,40,39,38,37,36,35,34,34,33,],
                ),
                SizedBox(height: 30.w,),
              ],
            ),
          )

        ],
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
          ? true
          : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity( 0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor: isSelected
            ? rawDataSet.color
            : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
        rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 1 : 1,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: 'GINOVO',
        color: Color(0xff09FF32),
        values: [
          300,
          50,
          100,
          500,
          200,
        ],
      ),
    ];
  }
}


class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });

  final String title;
  final Color color;
  final List<double> values;
}


class HistoryRecord extends StatefulWidget {
  const HistoryRecord({super.key});

  @override
  State<HistoryRecord> createState() => _HistoryRecordState();
}

class _HistoryRecordState extends State<HistoryRecord> {
  List<HistoryRecordModel> records = [HistoryRecordModel(dateTime:DateTime.now(), targetDistance: 3, puttDistance: 2.7, onClickFunc: (){})];
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: 20.w,),
        ...records.map((e){
          return HistoryRecordItem(model: e);
        }).toList(),
      ],
    );
  }
}


class HistoryRecordItem extends StatefulWidget {
  const HistoryRecordItem({super.key,
    required this.model
  });
  final HistoryRecordModel model;
  @override
  State<HistoryRecordItem> createState() => _HistoryRecordItemState();
}

class _HistoryRecordItemState extends State<HistoryRecordItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: PanelContainer(
          childWidget:
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                  Text("${DateFormat("yyyy.MM.dd HH:mm").format(widget.model.dateTime)}",
                  style: TextStyle(fontSize: 12.sp,
                  color: Color(0xff4C4C4C)),
                  ),
                SizedBox(height: 2.w,),
                Text("Target: ${widget.model.targetDistance.toStringAsFixed(1)}m, Putt: ${widget.model.puttDistance.toStringAsFixed(1)}m",
                  style: TextStyle(fontSize: 14.sp,
                      color: Color(0xff000000)),
                )
              ],
            )),
            Icon(Icons.keyboard_arrow_right,size: 14.w,),
          ],
        )
      ),
    );
  }
}

class HistoryRecordModel{
  const HistoryRecordModel({
    required this.dateTime,
    required this.targetDistance,
    required this.puttDistance,
    required this.onClickFunc,
});

  final DateTime dateTime;
  final double targetDistance;
  final double puttDistance;
  final Function onClickFunc;
}