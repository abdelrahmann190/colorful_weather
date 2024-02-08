// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:colorful_weather/features/core/error/exceptions.dart';
import 'package:colorful_weather/features/core/error/failures.dart';
import 'package:colorful_weather/features/core/network/network_info.dart';
import 'package:colorful_weather/features/core/services/app_shared_preferences.dart';
import 'package:colorful_weather/features/core/services/current_location_services.dart';
import 'package:colorful_weather/features/core/utils/date_formatter.dart';
import 'package:colorful_weather/features/main_weather_page/data/data_source/weather_local_data_source.dart';
import 'package:colorful_weather/features/main_weather_page/data/data_source/weather_remote_data_source.dart';
import 'package:colorful_weather/features/main_weather_page/data/models/weekly_forecast_model.dart';
import 'package:colorful_weather/features/main_weather_page/domain/entities/current_weather.dart';
import 'package:colorful_weather/features/main_weather_page/domain/entities/weekly_forecast.dart';
import 'package:colorful_weather/features/main_weather_page/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final WeatherLocalDataSource weatherLocalDataSource;
  final NetworkInfo networkInfo;
  final CurrentLocationServices currentLocationServices;
  final AppSharedPreferences appSharedPreferences;
  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
    required this.weatherLocalDataSource,
    required this.networkInfo,
    required this.currentLocationServices,
    required this.appSharedPreferences,
  });
  @override
  Future<Either<Failure, CurrentWeather>> getCurrentWeather(
      int currentCityIndex) async {
    if (await networkInfo.isConnected) {
      return await _checkCachedCurrentWeatherDataAgainstCurrentDate(
          currentCityIndex);
    } else {
      return await _getLocalCurrentWeather(
        currentCityIndex,
      );
    }
  }

  Future<Either<Failure, CurrentWeather>>
      _checkCachedCurrentWeatherDataAgainstCurrentDate(
          int currentCityIndex) async {
    try {
      final String cachedDate = await weatherLocalDataSource
          .getCachedCurrentWeather(currentCityIndex)
          .then((value) => value.lastUpdated);
      final CurrentWeather localCurrentWeather = await weatherLocalDataSource
          .getCachedCurrentWeather(currentCityIndex);

      if (DateFormatter.checkIfCachedHourIsTheSameAsCurrentHour(cachedDate)) {
        return Right(localCurrentWeather);
      } else {
        return await _getLiveCurrentWeatherData(currentCityIndex);
      }
    } on Exception {
      return await _getLiveCurrentWeatherData(currentCityIndex);
    }
  }

  Future<Either<Failure, CurrentWeather>> _getLiveCurrentWeatherData(
      int currentCityIndex) async {
    try {
      final currentWeatherData =
          await weatherRemoteDataSource.getCurrentWeather(currentCityIndex);
      weatherLocalDataSource.cacheCurrentWeatherData(
        currentWeatherData,
        currentCityIndex,
      );
      return Right(
        currentWeatherData,
      );
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, CurrentWeather>> _getLocalCurrentWeather(
      int currentCityIndex) async {
    try {
      final CurrentWeather localCurrentWeather = await weatherLocalDataSource
          .getCachedCurrentWeather(currentCityIndex);
      return Right(localCurrentWeather);
    } on CacheException catch (error) {
      return Left(
        CacheFailure(
          error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<WeeklyForecast>>> getWeeklyWeatherForecast(
      int currentCityIndex) async {
    if (await networkInfo.isConnected) {
      return await _getWeeklyForecast(currentCityIndex);
    } else {
      try {
        return Right(
          await weatherLocalDataSource
              .getCachedWeeklyForecastWeather(currentCityIndex),
        );
      } on CacheException catch (e) {
        return Left(
          CacheFailure(
            e.toString(),
          ),
        );
      }
    }
  }

  Future<Either<Failure, List<WeeklyForeCastModel>>> _getWeeklyForecast(
      int currentCityIndex) async {
    try {
      final isDataCurrent = await _isCachedDataCurrent(currentCityIndex);
      if (isDataCurrent) {
        return Right(
          await weatherLocalDataSource.getCachedWeeklyForecastWeather(
            currentCityIndex,
          ),
        );
      } else {
        return await _fetchAndCacheData(currentCityIndex);
      }
    } catch (e) {
      return Left(
        CacheFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<bool> _isCachedDataCurrent(int index) async {
    try {
      final cachedData =
          await weatherLocalDataSource.getCachedWeeklyForecastWeather(index);

      final cachedDate = cachedData[0].date;
      return DateFormatter.checkIfCachedDayIsTheSameAsCurrentDay(cachedDate);
    } on CacheException {
      return false;
    }
  }

  Future<Either<Failure, List<WeeklyForeCastModel>>> _fetchAndCacheData(
      int index) async {
    final currentWeeklyForecast =
        await weatherRemoteDataSource.getWeeklyForecastWeather(index);
    await weatherLocalDataSource.cacheWeeklyForecastWeatherData(
        currentWeeklyForecast, index);
    return Right(currentWeeklyForecast);
  }

  @override
  Future<Either<Failure, String>> addCurrentCityToSavedCitiesList() async {
    try {
      final cityName =
          await currentLocationServices.getCityNameFromLocationServices();
      weatherLocalDataSource.cacheCurrentCitiesList(cityName);
      await appSharedPreferences.setDefaultCitySelectedToTrue();

      return Right(
        cityName,
      );
    } on LocationException catch (e) {
      return Left(
        LocationFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> addCityNameFromCitySelectionListToSavedCitiesList(
      String cityToBeAddedToTheList) async {
    return weatherLocalDataSource
        .cacheCurrentCitiesList(cityToBeAddedToTheList);
  }

  @override
  Future<List<String>> getSavedCitiesList() async {
    return weatherLocalDataSource.getSavedCitiesList();
  }

  @override
  removeCityFromSavedCitiesList(String cityToBeRemoved) async {
    await weatherLocalDataSource.removeCityFromSavedCitiesList(cityToBeRemoved);
  }

  @override
  updateSavedCitiesList(List<String> savedCitiesList) async {
    await weatherLocalDataSource.updateSavedCitiesList(savedCitiesList);
  }

  @override
  Future<bool> setWeatherDataType(bool isDataInCelsious) async {
    return weatherLocalDataSource.setWeatherDataType(isDataInCelsious);
  }

  @override
  Future<bool> checkIfDataInCelsious() async {
    return weatherLocalDataSource.checkIfDataInCelsious();
  }
}
