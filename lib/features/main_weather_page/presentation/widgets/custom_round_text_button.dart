// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomRoundTextButton extends StatelessWidget {
  final String buttonText;
  final Color buttonTextColor;
  final Color buttonBackgroundColor;
  final void Function()? onTap;
  const CustomRoundTextButton({
    Key? key,
    required this.buttonText,
    required this.buttonTextColor,
    required this.buttonBackgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: buttonBackgroundColor,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: buttonTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
