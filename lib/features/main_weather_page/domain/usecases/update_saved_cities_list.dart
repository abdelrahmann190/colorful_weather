import 'package:colorful_weather/features/main_weather_page/domain/repositories/weather_repository.dart';

class UpdateSavedCitiesList {
  final WeatherRepository _weatherRepository;

  UpdateSavedCitiesList(
    this._weatherRepository,
  );
  Future<void> call(List<String> savedCitiesList) async {
    await _weatherRepository.updateSavedCitiesList(savedCitiesList);
  }
}
