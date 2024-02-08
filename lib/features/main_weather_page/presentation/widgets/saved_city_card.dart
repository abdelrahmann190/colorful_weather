// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SavedCityCard extends StatelessWidget {
  final Color highlightColor;
  final Color backgroundColor;
  final void Function()? onTap;
  final String text;
  final Icon icon;
  const SavedCityCard({
    Key? key,
    required this.highlightColor,
    required this.backgroundColor,
    this.onTap,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: key,
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        highlightColor: highlightColor,
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          HapticFeedback.lightImpact();
          if (onTap != null) onTap!();
        },
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 200,
          ),
          padding: const EdgeInsets.all(
            15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
              ),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
