import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:colorful_weather/features/core/services/app_routes.dart';
import '../controllers/app_controller_bloc/app_controller_bloc.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/splash_page_scroll_points.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 500,
              child: PageView.builder(
                controller: _pageController,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/splash/splash-$index.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: 250,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white54,
                            ),
                            child: Center(
                              child: Text(
                                splashPagesTextList[index],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  setState(
                    () {
                      currentIndex = value;
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              width: 100,
              child: _buildScrollableDots(),
            ),
            GestureDetector(
              onTap: _nextButtonOnTap,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 30),
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.orange,
                ),
                child: Center(
                  child: BlocConsumer<AppControllerBloc, AppControllerState>(
                    listener: (context, state) {
                      if (state is SavedCitiesListLoaded) {
                        Navigator.of(context)
                            .popAndPushNamed(AppRoutes.mainWeatherPageRoute);
                      } else if (state is CityNameError) {
                        Navigator.of(context)
                            .popAndPushNamed(AppRoutes.citySelectionPageRoute);
                      }
                    },
                    builder: (context, state) {
                      return const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> splashPagesTextList = [
    'This is Colorful Weather',
    'We keep it fast',
    'And simple, Use It',
  ];

  Widget _buildScrollableDots() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: ScrollPoints(
            size: index == currentIndex ? 20 : 10,
            color: index == currentIndex ? Colors.orange : Colors.grey,
          ),
        );
      },
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  Future<void> _nextButtonOnTap() async {
    _pageController.nextPage(
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.ease,
    );
    if (currentIndex == 2) {
      BlocProvider.of<AppControllerBloc>(context).add(
        const LoadCityNameFromLocationServicesEvent(),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
