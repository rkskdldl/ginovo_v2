import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ginovo_result/presentation/widgets/distance_bar_widget.dart';

import 'data_panel.dart';

class PuttDistancePanel extends StatefulWidget {
  const PuttDistancePanel({super.key,required this.data});
  final List<DistanceBarElementModel> data;
  @override
  State<PuttDistancePanel> createState() => _PuttDistancePanelState();
}

class _PuttDistancePanelState extends State<PuttDistancePanel> {
  List<DistanceBarElementModel> data = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timestamp){
        setState(() {
          data = widget.data;
          data.sort((a,b)=>a.index.compareTo(b.index));
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PanelContainer(
        titleWidget: Align(
          alignment: Alignment.centerLeft,
          child: Text("Putt Distance(m)",
            style: TextStyle(
              fontSize: 20.sp,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        childWidget:Container(
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Hitting Target",
                    style: TextStyle(
                      fontSize:8.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff474747),
                    ),
                  ),
                  SizedBox(height: 8.w,),
                  Text("",
                    style: TextStyle(
                      fontSize:8.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff474747),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  child:LayoutBuilder(builder: (ctx,constraints){
                    return  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        constraints: BoxConstraints(minWidth: constraints.maxWidth),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ...data.map((e)=>DistanceBarWidget(realDistance: e.realDistance, baseDistance: e.baseDistance, index: e.index)).toList(),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}

class DistanceBarElementModel{
  double realDistance;
  double baseDistance;
  int index;

  DistanceBarElementModel({
    required this.realDistance,
    required this.baseDistance,
    required this.index,
});
}
