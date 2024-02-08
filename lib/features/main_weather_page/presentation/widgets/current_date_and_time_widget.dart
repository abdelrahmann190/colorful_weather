// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:colorful_weather/features/core/utils/date_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CurrentDateAndTimeWidget extends StatelessWidget {
  final Color randomColor;
  final String lastUpdatedDateAndTime;
  const CurrentDateAndTimeWidget({
    Key? key,
    required this.randomColor,
    required this.lastUpdatedDateAndTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.px),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.black,
      ),
      child: Text(
        DateFormatter.formatCurrentWeatherDate(
          lastUpdatedDateAndTime,
        ),
        style: TextStyle(
          color: randomColor,
          fontSize: 17.sp,
        ),
      ),
    );
  }
}
