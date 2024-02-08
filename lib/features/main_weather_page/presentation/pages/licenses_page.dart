// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:colorful_weather/features/main_weather_page/presentation/pages/license_detail_page.dart';
import 'package:colorful_weather/oss_licenses.dart';

class LicencesPage extends StatelessWidget {
  final Color? backgroundColor;
  const LicencesPage({
    Key? key,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Center(
          child: Text(
            "Licences",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: ossLicenses.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => LicenceDetailPage(
                        title: ossLicenses[index].name[0].toUpperCase() +
                            ossLicenses[index].name.substring(1),
                        licence: ossLicenses[index].license!,
                        backgroundColor: backgroundColor,
                      ),
                    ),
                  );
                },
                //capitalize the first letter of the string
                title: Text(
                  ossLicenses[index].name[0].toUpperCase() +
                      ossLicenses[index].name.substring(1),
                ),
                subtitle: Text(ossLicenses[index].description),
              ),
            ),
          );
        },
      ),
    );
  }
}
