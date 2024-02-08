// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MainWeatehrPageLoadingWidget extends StatelessWidget {
  final Color randomColor;
  const MainWeatehrPageLoadingWidget({
    Key? key,
    required this.randomColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: randomColor,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
