// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:colorful_weather/features/main_weather_page/presentation/widgets/circular_border_container.dart';

class NavigationTextCard extends StatelessWidget {
  final String navigationText;
  final void Function()? onTap;
  const NavigationTextCard({
    Key? key,
    required this.navigationText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              if (onTap != null) onTap!();
            },
            child: CircularBorderContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    navigationText,
                    style:
                        TextStyle(fontSize: 15.px, fontWeight: FontWeight.w400),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
