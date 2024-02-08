// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CurrentWeatherConditionText extends StatelessWidget {
  final String currentWeatherConditionText;
  const CurrentWeatherConditionText({
    Key? key,
    required this.currentWeatherConditionText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        currentWeatherConditionText,
        style: TextStyle(
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
