import 'package:dartz/dartz.dart';
import 'package:colorful_weather/features/core/domain/usecases/usecase.dart';
import 'package:colorful_weather/features/core/error/failures.dart';
import 'package:colorful_weather/features/main_weather_page/domain/entities/current_weather.dart';
import 'package:colorful_weather/features/main_weather_page/domain/repositories/weather_repository.dart';

class GetCurrentWeather implements UseCase<CurrentWeather, int> {
  final WeatherRepository weatherRepository;

  GetCurrentWeather({
    required this.weatherRepository,
  });
  @override
  Future<Either<Failure, CurrentWeather>> call(int currentCityIndex) {
    return weatherRepository.getCurrentWeather(currentCityIndex);
  }
}
