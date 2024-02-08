import 'package:colorful_weather/features/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class WeeklyForecastRowWidget extends StatelessWidget {
  const WeeklyForecastRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.weeklyForecast,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Icon(
            Icons.arrow_forward_outlined,
          )
        ],
      ),
    );
  }
}
