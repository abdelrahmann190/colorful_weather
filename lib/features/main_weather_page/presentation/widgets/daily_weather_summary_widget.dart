// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:colorful_weather/features/core/utils/app_strings.dart';
import 'package:colorful_weather/features/main_weather_page/domain/entities/current_weather.dart';

class DailyWeatherSummaryWidget extends StatelessWidget {
  final CurrentWeather currentWeather;
  final bool isDataInC;

  const DailyWeatherSummaryWidget({
    Key? key,
    required this.currentWeather,
    required this.isDataInC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.dailySummary,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Gap(1.h),
            Text(
              "Now it feels like ${isDataInC ? currentWeather.feelsLikeC : currentWeather.feelsLikeF}°\nThe temperature is felt in the range of ${isDataInC ? currentWeather.maxTempC : currentWeather.maxTempF}° to ${isDataInC ? currentWeather.minTempC : currentWeather.minTempF}°",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15.5.px,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
