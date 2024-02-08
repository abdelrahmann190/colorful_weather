import 'dart:convert';

import 'package:colorful_weather/features/main_weather_page/data/models/weekly_forecast_model.dart';

/// This class provides functions to convert lists and JSON strings to and from each other.
class JsonSerializer {
  /// Converts a list of objects to a JSON string.
  ///
  /// The list must be serializable to JSON.
  static String turnAListToJsonString({
    /// The list of objects to convert to JSON.
    required List listToBeStored,
  }) {
    /// Create a map to store the list.
    final Map mapToBeStored = {"list": listToBeStored};

    /// Encode the map to a JSON string.
    return jsonEncode(mapToBeStored).toString();
  }

  /// Converts a JSON string containing a list of objects to a list of objects.
  ///
  /// The JSON string must be valid and the objects must be deserializable from JSON.
  static List<WeeklyForeCastModel> turnJsonStringListToList({
    /// The JSON string containing the list of objects.
    required String jsonStringList,
  }) {
    /// Decode the JSON string to a map.
    final map = jsonDecode(jsonStringList);

    /// Extract the list of objects from the map.
    final listToBeReturned = List.from(map['list'])
        .map((e) => WeeklyForeCastModel.fromJson(e))
        .toList();

    /// Return the list of objects.
    return listToBeReturned;
  }
}
