// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/weather_forecast_row.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:colorful_weather/features/core/utils/date_formatter.dart';
import 'package:colorful_weather/features/core/utils/enums.dart';
import 'package:colorful_weather/features/main_weather_page/domain/entities/weekly_forecast.dart';

class WeatehrForecastPage extends StatefulWidget {
  final Map argumentsMap;
  const WeatehrForecastPage({
    Key? key,
    required this.argumentsMap,
  }) : super(key: key);

  @override
  State<WeatehrForecastPage> createState() => _WeatehrForecastPageState();
}

class _WeatehrForecastPageState extends State<WeatehrForecastPage> {
  late Color backgroundColor;
  late List<WeeklyForecast> weeklyForeCastList;
  late int currentCardIndex;
  late bool isDataInC;

  final PageController pageController = PageController();

  @override
  build(BuildContext context) {
    if (mounted) {
      Future.delayed(
        const Duration(microseconds: 100),
      ).then((value) => pageController.jumpToPage(currentCardIndex));
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: PageView.builder(
        controller: pageController,
        itemBuilder: (context, index) {
          final String currentDate = DateFormatter.formatWeeklyForecastPageDate(
            weeklyForeCastList[index].date,
          );
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: 30.px,
                left: 20.px,
                right: 20.px,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const BackButton(),
                            Expanded(
                              child: Center(
                                child: Text(
                                  currentDate,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.1,
                        ),
                      ],
                    ),
                  ),
                  Gap(50.px),
                  WeatherForecastRow(
                      label: "Condition:",
                      text: weeklyForeCastList[index].condition),
                  WeatherForecastRow(
                      label: "Average Humidity:",
                      text:
                          "${weeklyForeCastList[index].avgHumidity.toString()}%"),
                  WeatherForecastRow(
                      label: "Average Temperature:",
                      text:
                          "${isDataInC ? weeklyForeCastList[index].avgTempC : weeklyForeCastList[index].avgTempF} ${isDataInC ? "°C" : "°F"}"),
                  WeatherForecastRow(
                      label: "Maximum Temperature:",
                      text:
                          "${isDataInC ? weeklyForeCastList[index].maxTempC : weeklyForeCastList[index].maxTempF} ${isDataInC ? "°C" : "°F"}"),
                  WeatherForecastRow(
                      label: "Minimum Temperature:",
                      text:
                          "${isDataInC ? weeklyForeCastList[index].minTempC : weeklyForeCastList[index].minTempF} ${isDataInC ? "°C" : "°F"}"),
                  WeatherForecastRow(
                    label: "Maximum Wind Speed:",
                    text:
                        "${isDataInC ? weeklyForeCastList[index].maxWindKPH : weeklyForeCastList[index].maxWindMPH} ${isDataInC ? "Km/h" : "Mi/h"}",
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: weeklyForeCastList.length,
      ),
    );
  }

  @override
  void initState() {
    backgroundColor =
        widget.argumentsMap[WeatherForecastPageArguments.backgroundColor];
    weeklyForeCastList =
        widget.argumentsMap[WeatherForecastPageArguments.weeklyForeCastList];
    currentCardIndex =
        widget.argumentsMap[WeatherForecastPageArguments.currentCardIndex];
    isDataInC = widget.argumentsMap[WeatherForecastPageArguments.isDataInC];

    super.initState();
  }
}
