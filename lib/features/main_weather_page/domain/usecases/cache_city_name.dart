import 'package:colorful_weather/features/main_weather_page/domain/repositories/weather_repository.dart';

class CacheCityName {
  final WeatherRepository weatherRepository;

  CacheCityName({required this.weatherRepository});

  Future<void> call(String cityToBeAddedToTheList) async {
    return await weatherRepository
        .addCityNameFromCitySelectionListToSavedCitiesList(
            cityToBeAddedToTheList);
  }
}
