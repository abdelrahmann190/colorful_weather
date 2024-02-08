import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  final SharedPreferences _sharedPreferences;

  AppSharedPreferences(this._sharedPreferences);

  bool checkIfTheAppIsBeingOpenedForTheFirstTime() {
    final appOpenedBefore = _sharedPreferences.getBool('appOpenedBefore');
    if (appOpenedBefore != null) return true;
    _sharedPreferences.setBool('appOpenedBefore', true);
    return false;
  }

  bool checkIfDefaultCityHasBeenSelected() {
    final defaultCitySelected =
        _sharedPreferences.getBool('defaultCitySelected');
    if (defaultCitySelected != null) return true;
    return false;
  }

  Future<void> setDefaultCitySelectedToTrue() async {
    _sharedPreferences.setBool('defaultCitySelected', true);
  }
}
