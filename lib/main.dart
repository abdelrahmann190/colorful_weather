// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:colorful_weather/colorful_weather_app.dart';
import 'package:flutter/material.dart';

import 'package:colorful_weather/features/core/services/get_it_service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.initServiceLocator();

  runApp(
    ColorfulWeatherApp(
      appRouter: getItServiceLocator(),
      appSharedPreferences: getItServiceLocator(),
    ),
  );
}
