// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:colorful_weather/features/main_weather_page/domain/entities/current_weather.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/controllers/app_controller_bloc/app_controller_bloc.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/city_name_text.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/current_date_and_time_widget.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/current_weather_big_text.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/current_weather_condition_text.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/daily_weather_summary_widget.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/custom_drop_down_button.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/weather_conditions_card.dart';

class MainPageCurrentWeatherSection extends StatelessWidget {
  final Color randomColor;
  final AppControllerBloc appControllerBloc;
  final CurrentWeather currentWeather;
  final List<String> savedCitiesList;
  final bool isDataInC;
  const MainPageCurrentWeatherSection({
    Key? key,
    required this.randomColor,
    required this.appControllerBloc,
    required this.currentWeather,
    required this.savedCitiesList,
    required this.isDataInC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 5,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomDropDownButton(
                  backgroundColor: randomColor,
                  savedCitiesList: savedCitiesList,
                  appControllerBloc: appControllerBloc,
                  currentContext: context,
                  dataIndex: isDataInC ? 0 : 1,
                ),
                Expanded(
                  child: Center(
                    child: CityNameText(
                      cityName: currentWeather.cityName.toUpperCase(),
                    ),
                  ),
                ),
              ],
            ),
            Gap(5.px),
            CurrentDateAndTimeWidget(
              randomColor: randomColor,
              lastUpdatedDateAndTime: currentWeather.lastUpdated,
            ),
            Gap(1.7.h),
            CurrentWeatherConditionText(
                currentWeatherConditionText: currentWeather.condition),
            CurrentWeatherBigText(
              currentWeather: currentWeather,
              isDataInC: isDataInC,
            ),
            DailyWeatherSummaryWidget(
              isDataInC: isDataInC,
              currentWeather: currentWeather,
            ),
            Gap(1.h),
            WeatherConditionsCard(
              backgroundColor: randomColor,
              currentWeather: currentWeather,
              isDataInC: isDataInC,
            ),
            Gap(2.5.h),
          ],
        ),
      ),
    );
  }
}
