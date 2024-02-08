// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:colorful_weather/features/core/services/app_routes.dart';
import 'package:colorful_weather/features/core/services/app_shared_preferences.dart';
import 'package:colorful_weather/features/core/services/get_it_service_locator.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/controllers/app_controller_bloc/app_controller_bloc.dart';

class CitySelectionPage extends StatefulWidget {
  final bool defaultCityBeenSelected;
  final Color? backgroundColor;
  const CitySelectionPage({
    Key? key,
    required this.defaultCityBeenSelected,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<CitySelectionPage> createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 25,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  if (widget.defaultCityBeenSelected) const BackButton(),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Pleasse Select Your Default City',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(15),
              const Divider(
                thickness: 1,
              ),
              const Gap(15),

              ///Adding CSC Picker Widget in app
              CSCPicker(
                jsonFilePath: 'assets/country.json',

                ///Enable disable state dropdown [OPTIONAL PARAMETER]
                showStates: true,

                /// Enable disable city drop down [OPTIONAL PARAMETER]
                showCities: true,

                ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                flagState: CountryFlag.DISABLE,
                // countryFilter: [CscCountry],
                ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                dropdownDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

                ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                disabledDropdownDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                ),

                ///placeholders for dropdown search field
                countrySearchPlaceholder: "Country",
                stateSearchPlaceholder: "State",
                citySearchPlaceholder: "City",

                ///labels for dropdown
                countryDropdownLabel: "Country",
                stateDropdownLabel: "State",
                cityDropdownLabel: "City",

                selectedItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),

                ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                dropdownHeadingStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),

                ///DropdownDialog Item style [OPTIONAL PARAMETER]
                dropdownItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),

                ///Dialog box radius [OPTIONAL PARAMETER]
                dropdownDialogRadius: 30.0,

                ///Search bar radius [OPTIONAL PARAMETER]
                searchBarRadius: 30.0,

                ///triggers once country selected in dropdown
                onCountryChanged: (value) {
                  setState(() {
                    ///store value in country variable
                    countryValue = value;
                  });
                },

                ///triggers once state selected in dropdown
                onStateChanged: (value) {
                  setState(() {
                    ///store value in state variable
                    stateValue = value ?? "";
                  });
                },

                ///triggers once city selected in dropdown
                onCityChanged: (value) {
                  setState(() {
                    ///store value in city variable
                    cityValue = value ?? "";
                  });
                },
              ),
              const Gap(20),
              SizedBox(
                height: address.isEmpty ? 0 : 30,
                child: Text(
                  address,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (cityValue.isEmpty && stateValue.isEmpty) {
                    setState(
                      () {
                        address = "Please select a city first";
                      },
                    );
                  } else if (cityValue.isNotEmpty && cityValue != '') {
                    saveCityNameAndNavigate(context, cityValue);
                  } else if (stateValue.isNotEmpty && stateValue != '') {
                    saveCityNameAndNavigate(context, stateValue);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black,
                  ),
                  child: const Text(
                    "Add Selected City",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveCityNameAndNavigate(BuildContext context, String cityName) async {
    final appSharedPreferences = getItServiceLocator<AppSharedPreferences>();
    BlocProvider.of<AppControllerBloc>(context).add(
      AddCityNameFromCitySelectionListToSavedCitiesListEvent(
          selectedCityName: "$countryValue - $cityName"),
    );
    appSharedPreferences.setDefaultCitySelectedToTrue().then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.mainWeatherPageRoute,
        (Route<dynamic> route) => false,
      );
    });
  }
}
