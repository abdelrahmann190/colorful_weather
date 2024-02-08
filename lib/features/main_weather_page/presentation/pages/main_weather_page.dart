import 'package:colorful_weather/features/core/services/app_routes.dart';
import 'package:colorful_weather/features/core/utils/enums.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/weather_error_widget.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/main_page_current_weather_section.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/main_weather_page_loading_widget.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/weekly_forecast_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:colorful_weather/features/core/utils/app_colors.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/weather_forecast_card.dart';

import '../controllers/app_controller_bloc/app_controller_bloc.dart';

class MainWeatherPage extends StatefulWidget {
  const MainWeatherPage({super.key});

  @override
  State<MainWeatherPage> createState() => _MainWeatherPageState();
}

class _MainWeatherPageState extends State<MainWeatherPage> {
  int colorIndex = 0;
  var randomColor = AppColors.generateRandomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedContainer(
        duration: const Duration(
          milliseconds: 800,
        ),
        color: randomColor,
        child: BlocBuilder<AppControllerBloc, AppControllerState>(
          buildWhen: (previous, current) {
            return current is CurrentWeatherState;
          },
          builder: (context, state) {
            if (state is CurrentWeatherState) {
              return PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (pageIndex) async {
                  setState(
                    () {
                      randomColor = AppColors.generateRandomColor();
                    },
                  );
                  manageBlocFunctions(pageIndex);
                },
                itemCount: state.savedCitiesList.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: buildCurrentWeatherSection(state),
                      ),
                      const WeeklyForecastRowWidget(),
                      const Gap(20),
                      buildWeatherForecastSection(),
                    ],
                  );
                },
              );
            } else {
              return MainWeatehrPageLoadingWidget(randomColor: randomColor);
            }
          },
        ),
      ),
    );
  }

  Widget buildCurrentWeatherSection(
    CurrentWeatherState state,
  ) {
    if (state is CurrentWeatherLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    } else if (state is CurrentWeatherLoadingError) {
      return WeatherErrorWidget(errorMessage: state.errormessage);
    } else if (state is CurrentWeatherLoaded) {
      return MainPageCurrentWeatherSection(
          randomColor: randomColor,
          appControllerBloc: BlocProvider.of<AppControllerBloc>(context),
          currentWeather: state.currentWeather,
          savedCitiesList: state.savedCitiesList,
          isDataInC: state.isDataInC);
    } else {
      return Container();
    }
  }

  Widget buildWeatherForecastSection() {
    return Expanded(
      child: BlocBuilder<AppControllerBloc, AppControllerState>(
        buildWhen: (previous, current) {
          return current is WeeklyWeatherForecastState;
        },
        builder: (context, state) {
          if (state is WeeklyWeatherForecastLoaded) {
            return Center(
              child: ListView.builder(
                itemCount: state.weeklyForecastList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return WeatherForecastCard(
                    expectedWeatherDegree: state.isDataInC
                        ? state.weeklyForecastList[index].avgTempC.toString()
                        : state.weeklyForecastList[index].avgTempF.toString(),
                    weatherIcon: state.weeklyForecastList[index].icon,
                    date: state.weeklyForecastList[index].date,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.pushNamed(
                        context,
                        AppRoutes.weatherForecastPageRoute,
                        arguments: weatherForecastArguments(state, index),
                      );
                    },
                  );
                },
              ),
            );
          } else if (state is WeeklyWeatherForecastLoadingError) {
            return WeatherErrorWidget(
              errorMessage: state.message,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Map weatherForecastArguments(WeeklyWeatherForecastLoaded state, int index) =>
      {
        WeatherForecastPageArguments.backgroundColor: randomColor,
        WeatherForecastPageArguments.weeklyForeCastList:
            state.weeklyForecastList,
        WeatherForecastPageArguments.currentCardIndex: index,
        WeatherForecastPageArguments.isDataInC: state.isDataInC,
      };

  void manageBlocFunctions(int currentCityIndex) {
    BlocProvider.of<AppControllerBloc>(context).add(
      GetCurrentWeatherEvent(currentCityIndex: currentCityIndex),
    );
    BlocProvider.of<AppControllerBloc>(context).add(
      GetWeeklyWeatherForecastEvent(currentCityIndex: currentCityIndex),
    );
  }

  @override
  void initState() {
    manageBlocFunctions(0);
    super.initState();
  }
}
