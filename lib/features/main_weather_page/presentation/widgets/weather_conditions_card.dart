// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:colorful_weather/features/main_weather_page/domain/entities/current_weather.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WeatherConditionsCard extends StatefulWidget {
  final Color backgroundColor;
  final CurrentWeather currentWeather;
  final bool isDataInC;
  const WeatherConditionsCard({
    Key? key,
    required this.backgroundColor,
    required this.currentWeather,
    required this.isDataInC,
  }) : super(key: key);

  @override
  State<WeatherConditionsCard> createState() => _WeatherConditionsCardState();
}

class _WeatherConditionsCardState extends State<WeatherConditionsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.px),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          weatherConditionItem(
            data:
                "${widget.isDataInC ? widget.currentWeather.windKPH : widget.currentWeather.windMPH} ${widget.isDataInC ? "Km/h" : "Mi/h"}",
            icon: Icons.waves,
            describtion: "wind",
          ),
          weatherConditionItem(
            data: "${widget.currentWeather.humidity} %",
            icon: Icons.water_drop_outlined,
            describtion: "humidity",
          ),
          weatherConditionItem(
            data:
                "${widget.isDataInC ? widget.currentWeather.visibilityKm : widget.currentWeather.visibilityMh} ${widget.isDataInC ? "Km" : "Mi"}",
            icon: Icons.remove_red_eye,
            describtion: "visibility",
          ),
        ],
      ),
    );
  }

  Widget weatherConditionItem({
    required dynamic data,
    required String describtion,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: widget.backgroundColor,
          size: 4.h,
        ),
        Gap(1.1.h),
        Text(
          data,
          style: TextStyle(
            color: widget.backgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
          ),
        ),
        Text(
          describtion,
          style: TextStyle(
            color: widget.backgroundColor,
          ),
        ),
      ],
    );
  }
}
