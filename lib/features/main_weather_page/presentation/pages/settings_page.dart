// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:colorful_weather/features/core/services/app_routes.dart';
import 'package:colorful_weather/features/core/utils/app_strings.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/controllers/app_controller_bloc/app_controller_bloc.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/navigation_text_card.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/headline_text.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/saved_cities_dialog.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/weather_data_type_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  final Color backgroundColor;
  const SettingsPage({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackButton(),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 30.px,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 0.8,
              ),
              Gap(15.px),
              const HeadlineText(
                entryText: 'Your Cities',
              ),
              Gap(15.px),
              BlocBuilder<AppControllerBloc, AppControllerState>(
                builder: (context, state) {
                  if (state is SavedCitiesListLoaded) {
                    final savedCitiesList = state.savedCitiesList;
                    final appControllerBloc =
                        BlocProvider.of<AppControllerBloc>(context);
                    return NavigationTextCard(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SavedCitiesDialog(
                              savedCitiesList: savedCitiesList,
                              backgroundColor: widget.backgroundColor,
                              appControllerBloc: appControllerBloc,
                            );
                          },
                        );
                      },
                      navigationText: "Default: ${savedCitiesList[0]}",
                    );
                  }
                  return Container();
                },
              ),
              Gap(15.px),
              const HeadlineText(
                entryText: 'Weather Data Type',
              ),
              Gap(15.px),
              BlocBuilder<AppControllerBloc, AppControllerState>(
                builder: (context, state) {
                  if (state is SavedCitiesListLoaded) {
                    final appControllerBloc =
                        BlocProvider.of<AppControllerBloc>(context);
                    return NavigationTextCard(
                      navigationText:
                          'Weather Data Type: ${state.isDataInC ? 'Celsious' : 'Fahrenheit'}',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return WeatherDataDialog(
                              backgroundColor: widget.backgroundColor,
                              appControllerBloc: appControllerBloc,
                              dataIndex: state.isDataInC ? 0 : 1,
                            );
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
              Gap(15.px),
              const HeadlineText(
                entryText: 'Info',
              ),
              Gap(15.px),
              NavigationTextCard(
                navigationText: 'Privacy Policy',
                onTap: () {
                  launchUrl(Uri.parse(AppStrings.privacyPlicyWebsite));
                },
              ),
              Gap(15.px),
              NavigationTextCard(
                navigationText: 'Licenses',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.licensesPageRoute,
                    arguments: widget.backgroundColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<AppControllerBloc>(context)
        .add(const LoadSavedCitiesListEvent());
    super.initState();
  }
}
