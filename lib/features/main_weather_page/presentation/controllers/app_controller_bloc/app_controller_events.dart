part of 'app_controller_bloc.dart';

abstract class AppControllerEvent extends Equatable {
  const AppControllerEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentWeatherEvent extends AppControllerEvent {
  final int currentCityIndex;

  const GetCurrentWeatherEvent({required this.currentCityIndex});
}

class GetWeeklyWeatherForecastEvent extends AppControllerEvent {
  final int currentCityIndex;

  const GetWeeklyWeatherForecastEvent({required this.currentCityIndex});
}

class UpdateSavedCitiesListEvent extends AppControllerEvent {
  final List<String> savedCitiesList;

  const UpdateSavedCitiesListEvent({required this.savedCitiesList});
}

class LoadCityNameFromLocationServicesEvent extends AppControllerEvent {
  final String? cityName;

  const LoadCityNameFromLocationServicesEvent({
    this.cityName,
  });
}

class CheckIfTheAppIsBeingOpenedForFirstTimeEvent extends AppControllerEvent {
  const CheckIfTheAppIsBeingOpenedForFirstTimeEvent();
}

class AddCityNameFromCitySelectionListToSavedCitiesListEvent
    extends AppControllerEvent {
  final String selectedCityName;
  const AddCityNameFromCitySelectionListToSavedCitiesListEvent(
      {required this.selectedCityName});
}

class LoadSavedCitiesListEvent extends AppControllerEvent {
  const LoadSavedCitiesListEvent();
}

class RemoveCityFromSavedCitiesListEvent extends AppControllerEvent {
  final String cityToBeRemoved;
  const RemoveCityFromSavedCitiesListEvent({required this.cityToBeRemoved});
}

class SetWeatherDataTypeEvent extends AppControllerEvent {
  final bool isDataInC;
  const SetWeatherDataTypeEvent({required this.isDataInC});
}
