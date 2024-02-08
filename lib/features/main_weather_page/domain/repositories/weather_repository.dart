import 'package:dartz/dartz.dart';
import 'package:colorful_weather/features/core/error/failures.dart';
import 'package:colorful_weather/features/main_weather_page/domain/entities/current_weather.dart';
import 'package:colorful_weather/features/main_weather_page/domain/entities/weekly_forecast.dart';

abstract class WeatherRepository {
  Future<Either<Failure, CurrentWeather>> getCurrentWeather(
      int currentCityIndex);
  Future<Either<Failure, List<WeeklyForecast>>> getWeeklyWeatherForecast(
      int currentCityIndex);
  Future<Either<Failure, String>> addCurrentCityToSavedCitiesList();
  Future<void> addCityNameFromCitySelectionListToSavedCitiesList(
      String cityToBeAddedToTheList);
  // Future<bool> checkIfTheAppIsBeingOpenedForFirstTime();
  Future<List<String>> getSavedCitiesList();
  removeCityFromSavedCitiesList(String cityToBeRemoved);
  Future<bool> setWeatherDataType(bool isDataInCelsious);
  Future<bool> checkIfDataInCelsious();
  Future<void> updateSavedCitiesList(List<String> savedCitiesList);
}
