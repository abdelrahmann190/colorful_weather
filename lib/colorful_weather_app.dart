import 'package:colorful_weather/app_router.dart';
import 'package:colorful_weather/features/core/services/app_routes.dart';
import 'package:colorful_weather/features/core/services/app_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ColorfulWeatherApp extends StatelessWidget {
  final AppSharedPreferences appSharedPreferences;
  final AppRouter appRouter;
  const ColorfulWeatherApp({
    Key? key,
    required this.appRouter,
    required this.appSharedPreferences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Colorful Weather',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.generateRoute,
          initialRoute:
              appSharedPreferences.checkIfTheAppIsBeingOpenedForTheFirstTime()
                  ? AppRoutes.mainWeatherPageRoute
                  : AppRoutes.splashPageRoute,
        );
      },
    );
  }
}
