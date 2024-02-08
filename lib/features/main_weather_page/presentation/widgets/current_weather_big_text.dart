// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:colorful_weather/features/main_weather_page/domain/entities/current_weather.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CurrentWeatherBigText extends StatelessWidget {
  final CurrentWeather currentWeather;
  final bool isDataInC;
  const CurrentWeatherBigText({
    Key? key,
    required this.currentWeather,
    required this.isDataInC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "${isDataInC ? currentWeather.tempC : currentWeather.tempF}°",
      style: TextStyle(
        fontSize: 19.6.h,
      ),
    );
  }
}
