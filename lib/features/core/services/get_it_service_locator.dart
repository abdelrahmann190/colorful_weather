import 'package:colorful_weather/app_router.dart';
import 'package:colorful_weather/features/core/network/network_info.dart';
import 'package:colorful_weather/features/core/services/current_location_services.dart';
import 'package:colorful_weather/features/main_weather_page/data/data_source/weather_remote_data_source.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/update_saved_cities_list.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:colorful_weather/features/core/services/app_shared_preferences.dart';

import 'package:colorful_weather/features/main_weather_page/data/data_source/weather_local_data_source.dart';
import 'package:colorful_weather/features/main_weather_page/data/repositories/weather_repository_impl.dart';
import 'package:colorful_weather/features/main_weather_page/domain/repositories/weather_repository.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/add_city_name_from_city_selection_list_to_saved_cities_list.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/add_current_city_to_cities_list.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/cache_city_name.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/check_if_data_in_celsious.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/get_current_weather_usecase.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/get_saved_cities_list.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/get_weekly_weather_forecast.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/remove_city_from_saved_cities_list.dart';
import 'package:colorful_weather/features/main_weather_page/domain/usecases/set_weather_data_type.dart';

import '../../main_weather_page/presentation/controllers/app_controller_bloc/app_controller_bloc.dart';

final GetIt getItServiceLocator = GetIt.instance;

class ServiceLocator {
  static Future<void> initServiceLocator() async {
    //Router
    getItServiceLocator.registerLazySingleton<AppRouter>(
      () => AppRouter(),
    ); //Data Source
    getItServiceLocator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(
        weatherLocalDataSource: getItServiceLocator(),
      ),
    );
    getItServiceLocator.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl(
        sharedPreferences: getItServiceLocator(),
      ),
    );

    //Repositories
    getItServiceLocator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(
        weatherRemoteDataSource: getItServiceLocator(),
        weatherLocalDataSource: getItServiceLocator(),
        networkInfo: getItServiceLocator(),
        currentLocationServices: getItServiceLocator(),
        appSharedPreferences: getItServiceLocator(),
      ),
    );
    //Use Cases
    getItServiceLocator.registerLazySingleton(
      () => GetCurrentWeather(
        weatherRepository: getItServiceLocator(),
      ),
    );
    getItServiceLocator.registerLazySingleton(
      () => GetWeeklyWeatherForecast(
        weatherRepository: getItServiceLocator(),
      ),
    );
    getItServiceLocator.registerLazySingleton(
      () => AddCurrentCityToCitiesList(
        weatherRepository: getItServiceLocator(),
      ),
    );
    getItServiceLocator.registerLazySingleton(
      () => CurrentLocationServices(),
    );

    getItServiceLocator.registerLazySingleton(
      () => CacheCityName(
        weatherRepository: getItServiceLocator(),
      ),
    );

    getItServiceLocator.registerLazySingleton(
      () => GetSavedCitiesList(
        getItServiceLocator(),
      ),
    );
    getItServiceLocator.registerLazySingleton(
      () => AddCityNameFromCitySelectionListToSavedCitiesList(
        weatherRepository: getItServiceLocator(),
      ),
    );
    getItServiceLocator.registerLazySingleton(
      () => RemoveCityFromSavedCitiesList(
        getItServiceLocator(),
      ),
    );
    getItServiceLocator.registerLazySingleton(
      () => SetWeathreDataType(
        getItServiceLocator(),
      ),
    );
    getItServiceLocator.registerLazySingleton(
      () => CheckIfDataInCelsious(
        weatherRepository: getItServiceLocator(),
      ),
    );
    getItServiceLocator.registerLazySingleton(
      () => UpdateSavedCitiesList(
        getItServiceLocator(),
      ),
    );
    //Bloc
    getItServiceLocator.registerFactory(
      () => AppControllerBloc(
        getItServiceLocator(),
        getItServiceLocator(),
        getItServiceLocator(),
        getItServiceLocator(),
        getItServiceLocator(),
        getItServiceLocator(),
        getItServiceLocator(),
        getItServiceLocator(),
        getItServiceLocator(),
        getItServiceLocator(),
      ),
    );

    //Core
    getItServiceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        connectionChecker: getItServiceLocator(),
      ),
    );

    getItServiceLocator.registerLazySingleton<AppSharedPreferences>(
      (() => AppSharedPreferences(
            getItServiceLocator(),
          )),
    );

    //External Packages
    final sharedPreferences = await SharedPreferences.getInstance();
    getItServiceLocator.registerLazySingleton(
      () => sharedPreferences,
    );

    getItServiceLocator.registerLazySingleton(
      () => InternetConnectionChecker(),
    );
  }
}
