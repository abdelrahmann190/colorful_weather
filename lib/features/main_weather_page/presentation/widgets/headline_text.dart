// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HeadlineText extends StatelessWidget {
  final String entryText;
  const HeadlineText({
    Key? key,
    required this.entryText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      entryText,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
    );
  }
}
