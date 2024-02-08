import 'package:colorful_weather/features/core/error/exceptions.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/// Service class to get the current city name using location services
class CurrentLocationServices {
  /// Function to get the city name from location services
  /// If location services are not enabled, the function will return an error
  /// If the location service permission is denied, the function will return an error
  /// If the location service permission is denied forever, the function will return an error
  /// If the location is successfully determined, the function will return the city name
  Future<String> getCityNameFromLocationServices() async {
    try {
      /// Variable to store the current location data
      final locationData = await _determinePositionUsingLocationServices();

      /// Get the placemarks from the location data
      List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude,
        locationData.longitude,
      );

      /// Check if the administrative area is available
      if (placemarks.last.administrativeArea == null ||
          placemarks.last.administrativeArea == '') {
        /// If the administrative area is not available, check if the country name is available
        if (placemarks.last.country != null && placemarks.last.country != '') {
          /// Return the country name
          return placemarks.last.country!;
        }

        /// Throw an exception if the country name is also not available
        throw LocationException();
      } else {
        /// Return the administrative area
        return placemarks.last.administrativeArea!;
      }
    } on Exception catch (err) {
      /// Throw a location exception with the error message
      throw LocationException(
        message: err.toString(),
      );
    }
  }

  Future<Position> _determinePositionUsingLocationServices() async {
    // Test if location services are enabled.

    await _askForLocationAccessPermission();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return position;
  }

  Future<void> _askForLocationAccessPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        throw LocationException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      throw LocationException();
    }
  }
}
