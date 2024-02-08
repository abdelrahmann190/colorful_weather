// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CityNameText extends StatelessWidget {
  final String cityName;
  const CityNameText({
    Key? key,
    required this.cityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      cityName,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.px,
      ),
    );
  }
}
