import 'package:dartz/dartz.dart';
import 'package:colorful_weather/features/core/domain/usecases/usecase.dart';
import 'package:colorful_weather/features/core/error/failures.dart';
import 'package:colorful_weather/features/main_weather_page/domain/entities/weekly_forecast.dart';
import 'package:colorful_weather/features/main_weather_page/domain/repositories/weather_repository.dart';

class GetWeeklyWeatherForecast implements UseCase<List<WeeklyForecast>, int> {
  final WeatherRepository weatherRepository;

  GetWeeklyWeatherForecast({
    required this.weatherRepository,
  });
  @override
  Future<Either<Failure, List<WeeklyForecast>>> call(
      int currentCityIndex) async {
    return await weatherRepository.getWeeklyWeatherForecast(currentCityIndex);
  }
}
