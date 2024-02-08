import 'package:colorful_weather/features/main_weather_page/presentation/widgets/custom_round_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomRoundTextButton(
        buttonText: 'Cancel',
        buttonTextColor: Colors.white,
        buttonBackgroundColor: Colors.black,
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
        },
      ),
    );
  }
}
