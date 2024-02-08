import 'package:colorful_weather/features/core/services/app_shared_preferences.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/pages/city_selection_page.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/pages/licenses_page.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/pages/settings_page.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/pages/weather_forecast_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colorful_weather/features/core/services/app_routes.dart';
import 'package:colorful_weather/features/core/services/get_it_service_locator.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/pages/main_weather_page.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/pages/splash_page.dart';

import 'features/main_weather_page/presentation/controllers/app_controller_bloc/app_controller_bloc.dart';

/// Generates a route based on the given settings.
class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final appSharedPrefeences = getItServiceLocator<AppSharedPreferences>();

    switch (settings.name) {
      case AppRoutes.splashPageRoute:
        return MaterialPageRoute(
          /// Builds the SplashPage widget.
          builder: (_) => BlocProvider(
            /// Creates an instance of the AppControllerBloc.
            create: (context) => getItServiceLocator<AppControllerBloc>(),

            /// Builds the SplashPage widget.
            child: const SplashPage(),
          ),
        );
      case AppRoutes.mainWeatherPageRoute:
        return MaterialPageRoute(
          /// Builds the MainWeatherPage widget.
          builder: (_) => BlocProvider(
            /// Creates an instance of the AppControllerBloc.
            create: (context) => getItServiceLocator<AppControllerBloc>(),

            /// Builds the MainWeatherPage widget.
            child: appSharedPrefeences.checkIfDefaultCityHasBeenSelected()
                ? const MainWeatherPage()
                : const CitySelectionPage(
                    defaultCityBeenSelected: false,
                  ),
          ),
        );
      case AppRoutes.citySelectionPageRoute:
        return MaterialPageRoute(
          /// Builds the CitySelectionPage widget.
          builder: (_) => BlocProvider(
            /// Creates an instance of the AppControllerBloc.
            create: (context) => getItServiceLocator<AppControllerBloc>(),

            /// Builds the CitySelectionPage widget.
            child: CitySelectionPage(
              defaultCityBeenSelected: true,
              backgroundColor: settings.arguments as Color,
            ),
          ),
        );
      case AppRoutes.settingsPageRoute:
        return MaterialPageRoute(
          /// Builds the settings page widget.
          builder: (_) => BlocProvider(
            /// Creates an instance of the AppControllerBloc.
            create: (context) => getItServiceLocator<AppControllerBloc>(),

            /// Builds the settings page widget.
            child: SettingsPage(
              backgroundColor: settings.arguments as Color,
            ),
          ),
        );
      case AppRoutes.weatherForecastPageRoute:
        return MaterialPageRoute(
          /// Builds the settings page widget.
          builder: (_) => BlocProvider(
            /// Creates an instance of the AppControllerBloc.
            create: (context) => getItServiceLocator<AppControllerBloc>(),

            /// Builds the settings page widget.
            child: WeatehrForecastPage(
              argumentsMap: settings.arguments as Map,
            ),
          ),
        );
      case AppRoutes.licensesPageRoute:
        return MaterialPageRoute(
          /// Builds the licenses page widget.
          builder: (_) => LicencesPage(
            backgroundColor: settings.arguments as Color?,
          ),
        );
    }
    return null;
  }
}
