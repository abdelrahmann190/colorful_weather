import 'package:intl/intl.dart';

/// Class to format dates.
class DateFormatter {
  /// Checks if the cached hour is the same as the current hour.
  static bool checkIfCachedHourIsTheSameAsCurrentHour(String dateToBeChecked) {
    // Gets the current hour in the format "DDHH".
    final String currentHour = DateFormat('DDHH').format(
      DateTime.now(),
    );
    // Gets the hour to be checked in the format "DDHH".
    final hourToBeChecked = DateFormat('DDHH').format(
      DateTime.parse(dateToBeChecked),
    );

    // Checks if the current hour and the hour to be checked are the same.
    if (currentHour == hourToBeChecked) {
      return true;
    } else {
      return false;
    }
  }

  /// Checks if the cached day is the same as the current day.
  static Future<bool> checkIfCachedDayIsTheSameAsCurrentDay(
      String dateToBeCached) async {
    // Gets the current day in the format "D".
    final String currentDay = DateFormat('D').format(
      DateTime.now(),
    );
    // Gets the day to be checked in the format "D".
    final dayToBeChecked = DateFormat('D').format(
      DateTime.parse(dateToBeCached),
    );

    // Checks if the current day and the day to be checked are the same.
    if (currentDay == dayToBeChecked) {
      return true;
    } else {
      return false;
    }
  }

  /// Formats a weekly forecast date.
  static String formatWeeklyForecastDate(String date) {
    // Formats the date in the format "d MMM".
    return DateFormat('d MMM').format(
      DateTime.parse(date),
    );
  }

  /// Formats a current weather date.
  static String formatCurrentWeatherDate(String date) {
    // Formats the date in the format "EEEE, d MMMM - j".
    return "${DateFormat('EEEE, d MMMM - ').format(DateTime.parse(date))}${DateFormat('j').format(DateTime.parse(date))}";
  }

  /// Formats a weekly forecast page date.
  static String formatWeeklyForecastPageDate(String date) {
    // Formats the date in the format "EEEE, d MMMM".
    return DateFormat('EEEE, d MMMM').format(DateTime.parse(date));
  }
}
