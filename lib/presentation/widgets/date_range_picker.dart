import 'dart:core';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateRangePicker extends StatefulWidget {
  const DateRangePicker({super.key,
  required this.datePickCallBack,
  });
  final Function datePickCallBack;
  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  List<DateTime> dates =  [DateTime.now(), DateTime.now()];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async {
        List<DateTime?>? results = await showCalendarDatePicker2Dialog(
          context: context,
          config: CalendarDatePicker2WithActionButtonsConfig(calendarType: CalendarDatePicker2Type.range,
          ),
          dialogSize: Size(390.w, 420.w),
          value: dates,
          borderRadius: BorderRadius.circular(15),
        );

        if(results!=null){
          if(results.length>1){
            setState(() {
              dates = [results.elementAt(0)!,results.elementAt(1)!];
              widget.datePickCallBack(dates);
            });
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
          border: Border.all(color: Color(0xffE4E4E4), )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_month,color: Color(0xff565656),size: 18.w,),
            SizedBox(width: 12.w,),
            Text("${DateFormat("yyyy.MM.dd").format(dates[0])} ~ ${DateFormat("yyyy.MM.dd").format(dates[1])}",
            style: TextStyle(
              fontSize: 12.sp,
              color: Color(0xff4c4c4c),
            ),
            ),
            SizedBox(width: 12.w,),
          ],
        ),
      ),
    );
  }

}
