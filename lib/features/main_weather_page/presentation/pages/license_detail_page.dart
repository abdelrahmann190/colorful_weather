import 'package:flutter/material.dart';

class LicenceDetailPage extends StatelessWidget {
  final String title, licence;
  final Color? backgroundColor;
  const LicenceDetailPage({
    super.key,
    required this.title,
    required this.licence,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.black12,
        elevation: 0,
        title: Center(
          child: Text(
            title,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(8)),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  licence,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
