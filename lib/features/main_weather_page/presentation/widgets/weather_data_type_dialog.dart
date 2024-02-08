// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/cancel_button.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/custom_round_text_button.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/saved_city_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'package:colorful_weather/features/core/services/app_routes.dart';
import '../controllers/app_controller_bloc/app_controller_bloc.dart';

class WeatherDataDialog extends StatefulWidget {
  final Color backgroundColor;
  final AppControllerBloc appControllerBloc;
  final int dataIndex;

  const WeatherDataDialog({
    Key? key,
    required this.backgroundColor,
    required this.appControllerBloc,
    required this.dataIndex,
  }) : super(key: key);

  @override
  State<WeatherDataDialog> createState() => _WeatherDataDialogState();
}

class _WeatherDataDialogState extends State<WeatherDataDialog> {
  late int _dataIndex;
  final List labelsTextList = [
    "Show Weather Data in Celsious",
    "Show Weather Data in Fahrenheit",
  ];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      backgroundColor: widget.backgroundColor,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 230,
        child: Column(
          children: [
            Column(
              children: List.generate(
                2,
                (index) => SavedCityCard(
                  highlightColor: Colors.white10,
                  backgroundColor:
                      _dataIndex == index ? Colors.white10 : Colors.black12,
                  text: labelsTextList[index],
                  icon: const Icon(Icons.add),
                  onTap: () {
                    setState(() {
                      _dataIndex = index;
                    });
                  },
                ),
              ),
            ),
            buildActionsRow(context),
          ],
        ),
      ),
    );
  }

  Row buildActionsRow(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomRoundTextButton(
            buttonText: 'Set Data',
            buttonTextColor: Colors.black,
            buttonBackgroundColor: Colors.black12,
            onTap: () {
              setDataOnTap(context);
            },
          ),
        ),
        const Gap(10),
        const CancelButton(),
      ],
    );
  }

  void setDataOnTap(BuildContext context) {
    HapticFeedback.lightImpact();
    if (_dataIndex == 0) {
      widget.appControllerBloc.add(
        const SetWeatherDataTypeEvent(isDataInC: true),
      );
      Future.delayed(
        const Duration(milliseconds: 50),
      ).then(
        (value) => Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.mainWeatherPageRoute,
          (Route<dynamic> route) => false,
        ),
      );
    } else if (_dataIndex == 1) {
      widget.appControllerBloc.add(
        const SetWeatherDataTypeEvent(isDataInC: false),
      );
      Future.delayed(
        const Duration(milliseconds: 50),
      ).then(
        (value) => Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.mainWeatherPageRoute,
          (Route<dynamic> route) => false,
        ),
      );
    }
  }

  @override
  void initState() {
    _dataIndex = widget.dataIndex;
    super.initState();
  }
}
