import 'package:flutter/material.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';

class AppColors {
  /// Utility methods for generating random colors.
  static Color generateRandomColor() {
    /// Defines configuration for generating random colors.
    var randomColorOptions = Options(
      /// Sets the format of the color to an RGB array.
      format: Format.rgbArray,

      /// Sets the luminosity of the color to light.
      luminosity: Luminosity.light,
    );

    /// Generates a list of random RGB values.
    List<int> randomColorRGBValues = RandomColor.getColor(randomColorOptions);

    /// Return a color with the generated RGB values and an opacity of 1.
    return Color.fromRGBO(randomColorRGBValues[0], randomColorRGBValues[1],
        randomColorRGBValues[2], 1);
  }
}
