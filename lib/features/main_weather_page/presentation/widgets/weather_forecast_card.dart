// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:colorful_weather/features/core/utils/date_formatter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WeatherForecastCard extends StatelessWidget {
  final String expectedWeatherDegree;
  final String weatherIcon;
  final String date;
  final Function()? onTap;
  const WeatherForecastCard({
    Key? key,
    required this.expectedWeatherDegree,
    required this.weatherIcon,
    required this.date,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 25,
          left: 15,
          right: 15,
        ),
        width: 100,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "$expectedWeatherDegree°",
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
            SizedBox(
              width: 55.px,
              height: 55.px,
              child: CachedNetworkImage(
                imageUrl: "https:$weatherIcon",
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: Colors.black,
                ),
                color: Colors.black,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Text(
              DateFormatter.formatWeeklyForecastDate(date),
            ),
          ],
        ),
      ),
    );
  }
}
