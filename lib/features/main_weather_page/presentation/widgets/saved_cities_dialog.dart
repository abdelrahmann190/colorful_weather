// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/cancel_button.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/custom_round_text_button.dart';
import 'package:colorful_weather/features/main_weather_page/presentation/widgets/saved_city_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:colorful_weather/features/core/services/app_routes.dart';

import '../controllers/app_controller_bloc/app_controller_bloc.dart';

class SavedCitiesDialog extends StatefulWidget {
  final List<String> savedCitiesList;
  final Color backgroundColor;
  final AppControllerBloc appControllerBloc;
  const SavedCitiesDialog({
    Key? key,
    required this.savedCitiesList,
    required this.backgroundColor,
    required this.appControllerBloc,
  }) : super(key: key);

  @override
  State<SavedCitiesDialog> createState() => _SavedCitiesDialogState();
}

class _SavedCitiesDialogState extends State<SavedCitiesDialog> {
  int? selectedCityIndex;
  late List<String> savedCitiesList;
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
        constraints: const BoxConstraints(maxHeight: 546),
        padding: const EdgeInsets.all(15),
        height: savedCitiesList.length * 75 + 140,
        child: Column(
          children: [
            Expanded(
              child: ReorderableListView.builder(
                physics: const BouncingScrollPhysics(),
                buildDefaultDragHandles: savedCitiesList.length > 1,
                onReorder: (oldIndex, newIndex) {
                  if (newIndex == oldIndex) {
                  } else {
                    setState(
                      () {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final item = savedCitiesList.removeAt(oldIndex);
                        savedCitiesList.insert(newIndex, item);
                        widget.appControllerBloc.add(
                          UpdateSavedCitiesListEvent(
                              savedCitiesList: savedCitiesList),
                        );
                      },
                    );
                  }
                },
                proxyDecorator:
                    (Widget child, int index, Animation<double> animation) {
                  return Material(
                    color: Colors.transparent,
                    child: Container(
                      child: child,
                    ),
                  );
                },
                itemCount: savedCitiesList.length,
                itemBuilder: (context, index) {
                  return SavedCityCard(
                    key: ValueKey(index),
                    highlightColor: widget.backgroundColor.withAlpha(10),
                    backgroundColor: selectedCityIndex == index
                        ? Colors.white10
                        : Colors.black12,
                    text: savedCitiesList[index],
                    icon: const Icon(Icons.apps),
                    onTap: () {
                      setState(
                        () {
                          selectedCityIndex = index;
                        },
                      );
                    },
                  );
                },
              ),
            ),
            SavedCityCard(
              highlightColor: widget.backgroundColor.withAlpha(10),
              backgroundColor: Colors.black12,
              text: "Add New City",
              icon: const Icon(Icons.add),
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.citySelectionPageRoute,
                  arguments: widget.backgroundColor,
                );
              },
            ),
            buildActionsRow(context),
          ],
        ),
      ),
    );
  }

  Row buildActionsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomRoundTextButton(
            buttonText: 'Delete',
            buttonTextColor: Colors.black,
            buttonBackgroundColor: Colors.red,
            onTap: () {
              deleteSelectedCityOnTap();
            },
          ),
        ),
        const Gap(5),
        const CancelButton(),
      ],
    );
  }

  void deleteSelectedCityOnTap() {
    if (selectedCityIndex == null) {
      showCustomSnackBar('Please select a city first');
    } else if (selectedCityIndex == 0) {
      showCustomSnackBar("Can't Delete Default City");
    } else {
      widget.appControllerBloc.add(
        RemoveCityFromSavedCitiesListEvent(
          cityToBeRemoved: savedCitiesList[selectedCityIndex!],
        ),
      );
      widget.appControllerBloc.add(
        const GetCurrentWeatherEvent(currentCityIndex: 0),
      );

      Future.delayed(
        const Duration(
          milliseconds: 50,
        ),
      ).then(
        (value) => Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.mainWeatherPageRoute,
          (Route<dynamic> route) => false,
        ),
      );
    }
  }

  void showCustomSnackBar(String textToShow) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            textToShow,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    savedCitiesList = widget.savedCitiesList;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
