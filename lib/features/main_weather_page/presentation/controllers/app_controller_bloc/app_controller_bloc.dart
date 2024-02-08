// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/update_saved_cities_list.dart';
import 'package:equatable/equatable.dart';
import 'package:colorful_weather/features/core/domain/usecases/usecase.dart';

import 'package:colorful_weather/features/main_weather_page/domain/entities/current_weather.dart';
import 'package:colorful_weather/features/main_weather_page/domain/entities/weekly_forecast.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/add_city_name_from_city_selection_list_to_saved_cities_list.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/add_current_city_to_cities_list.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/cache_city_name.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/check_if_data_in_celsious.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/get_current_weather_usecase.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/get_saved_cities_list.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/get_weekly_weather_forecast.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/remove_city_from_saved_cities_list.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/set_weather_data_type.dart';

part 'app_controller_events.dart';
part 'app_controller_states.dart';

class AppControllerBloc extends Bloc<AppControllerEvent, AppControllerState> {
  final GetCurrentWeather _getCurrentWeatherUseCase;
  final GetWeeklyWeatherForecast _getWeeklyWeatherForecast;
  final AddCurrentCityToCitiesList _addCurrentCityToCitiesList;
  final CacheCityName _cacheCityName;
  final GetSavedCitiesList _getSavedCitiesList;
  final AddCityNameFromCitySelectionListToSavedCitiesList
      _addCityNameFromCitySelectionListToSavedCitiesList;
  final RemoveCityFromSavedCitiesList _removeCityFromSavedCitiesList;
  final SetWeathreDataType _setWeathreDataType;
  final CheckIfDataInCelsious _checkIfDataInCelsious;
  final UpdateSavedCitiesList _updateSavedCitiesList;
  AppControllerBloc(
    this._getCurrentWeatherUseCase,
    this._getWeeklyWeatherForecast,
    this._addCurrentCityToCitiesList,
    this._cacheCityName,
    this._getSavedCitiesList,
    this._addCityNameFromCitySelectionListToSavedCitiesList,
    this._removeCityFromSavedCitiesList,
    this._setWeathreDataType,
    this._checkIfDataInCelsious,
    this._updateSavedCitiesList,
  ) : super(WeatherInitial()) {
    on<GetCurrentWeatherEvent>(
      (event, emit) async {
        await _getCurrentWeatherFunction(event, emit);
      },
    );

    on<GetWeeklyWeatherForecastEvent>(
      (event, emit) async {
        final bool isDataInC = await _checkIfDataInCelsious();
        final citiesList = await _getSavedCitiesList();
        emit(WeeklyWeatherForecastLoading());
        final weeklyWeatherForecast = await _getWeeklyWeatherForecast(
          event.currentCityIndex,
        );
        weeklyWeatherForecast.fold(
          (l) => emit(
            WeeklyWeatherForecastLoadingError(
              message: l.message,
            ),
          ),
          (r) => emit(
            WeeklyWeatherForecastLoaded(
              weeklyForecastList: r,
              savedCitiesList: citiesList,
              isDataInC: isDataInC,
            ),
          ),
        );
      },
    );
    on<LoadCityNameFromLocationServicesEvent>(
      (event, emit) async {
        final isDataInC = await _checkIfDataInCelsious();

        final cityName = await _addCurrentCityToCitiesList(
          NoParams(),
        );
        final List<String> savedCitiesList = await _getSavedCitiesList();
        cityName.fold(
          (l) => emit(
            CityNameError(),
          ),
          (r) {
            _cacheCityName(r!);
            return emit(
              SavedCitiesListLoaded(
                savedCitiesList: savedCitiesList,
                isDataInC: isDataInC,
              ),
            );
          },
        );
      },
    );

    on<AddCityNameFromCitySelectionListToSavedCitiesListEvent>(
      (event, emit) async {
        final List savedCitiesList = await _getSavedCitiesList();
        final bool isDataInC = await _checkIfDataInCelsious();

        _addCityNameFromCitySelectionListToSavedCitiesList(
          event.selectedCityName,
        );

        emit(
          CurrentWeatherLoading(
            savedCitiesList: savedCitiesList,
            isDataInC: isDataInC,
          ),
        );
        final currentWeatherValue = await _getCurrentWeatherUseCase(0);
        currentWeatherValue.fold(
          (l) => emit(
            CurrentWeatherLoadingError(
              errormessage: l.message,
              savedCitiesList: savedCitiesList,
              isDataInC: isDataInC,
            ),
          ),
          (r) => emit(
            CurrentWeatherLoaded(
              currentWeather: r,
              savedCitiesList: savedCitiesList,
              isDataInC: isDataInC,
            ),
          ),
        );
      },
    );

    on<RemoveCityFromSavedCitiesListEvent>(
      (event, emit) async {
        _removeCityFromSavedCitiesList(
          event.cityToBeRemoved,
        );
        final List savedCitiesList = await _getSavedCitiesList();
        final bool isDataInC = await _checkIfDataInCelsious();

        emit(
          CurrentWeatherLoading(
            savedCitiesList: savedCitiesList,
            isDataInC: isDataInC,
          ),
        );
        final currentWeatherValue = await _getCurrentWeatherUseCase(0);
        currentWeatherValue.fold(
          (l) => emit(
            CurrentWeatherLoadingError(
              errormessage: l.message,
              savedCitiesList: savedCitiesList,
              isDataInC: isDataInC,
            ),
          ),
          (r) => emit(
            CurrentWeatherLoaded(
              currentWeather: r,
              savedCitiesList: savedCitiesList,
              isDataInC: isDataInC,
            ),
          ),
        );
      },
    );
    on<SetWeatherDataTypeEvent>(
      (event, emit) async {
        await _setWeathreDataType(
          event.isDataInC,
        );
        final List savedCitiesList = await _getSavedCitiesList();
        final bool isDataInC = await _checkIfDataInCelsious();

        emit(
          CurrentWeatherLoading(
            savedCitiesList: savedCitiesList,
            isDataInC: isDataInC,
          ),
        );
        final currentWeatherValue = await _getCurrentWeatherUseCase(0);
        currentWeatherValue.fold(
          (l) => emit(
            CurrentWeatherLoadingError(
              errormessage: l.message,
              savedCitiesList: savedCitiesList,
              isDataInC: isDataInC,
            ),
          ),
          (r) => emit(
            CurrentWeatherLoaded(
              currentWeather: r,
              savedCitiesList: savedCitiesList,
              isDataInC: isDataInC,
            ),
          ),
        );
      },
    );
    on<UpdateSavedCitiesListEvent>(
      (event, emit) async {
        await _updateSavedCitiesList(event.savedCitiesList);
        final isDataInC = await _checkIfDataInCelsious();

        emit(
          SavedCitiesListLoaded(
            savedCitiesList: event.savedCitiesList,
            isDataInC: isDataInC,
          ),
        );
      },
    );
    on<LoadSavedCitiesListEvent>(
      (event, emit) async {
        final List<String> savedCitiesList = await _getSavedCitiesList();
        final isDataInC = await _checkIfDataInCelsious();

        emit(
          SavedCitiesListLoaded(
            savedCitiesList: savedCitiesList,
            isDataInC: isDataInC,
          ),
        );
      },
    );
  }

  Future<void> _getCurrentWeatherFunction(
    GetCurrentWeatherEvent event,
    Emitter emit,
  ) async {
    final List savedCitiesList = await _getSavedCitiesList();
    final bool isDataInC = await _checkIfDataInCelsious();
    emit(
      CurrentWeatherLoading(
        savedCitiesList: savedCitiesList,
        isDataInC: isDataInC,
      ),
    );
    final currentWeatherValue =
        await _getCurrentWeatherUseCase(event.currentCityIndex);
    currentWeatherValue.fold(
      (l) => emit(
        CurrentWeatherLoadingError(
          errormessage: l.message,
          savedCitiesList: savedCitiesList,
          isDataInC: isDataInC,
        ),
      ),
      (r) => emit(
        CurrentWeatherLoaded(
          currentWeather: r,
          savedCitiesList: savedCitiesList,
          isDataInC: isDataInC,
        ),
      ),
    );
  }
}
