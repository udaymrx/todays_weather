import 'package:flutter/material.dart';
import 'package:today_weather/src/core/pallet/pallet.dart';

import '../../../data/models/today_weather_model.dart';
import 'widgets/hourly_section.dart';
import 'widgets/properties_section.dart';
import 'widgets/temperature_section.dart';
import 'widgets/unit_switch.dart';

TextStyle keyTextStyle() {
  return const TextStyle(
    fontSize: 15,
    color: Pallet.darkGrey,
  );
}

class CityPage extends StatelessWidget {
  const CityPage({super.key, required this.city});

  final TodayWeather city;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
            backgroundColor: Pallet.white,
            appBar: AppBar(
              backgroundColor: Pallet.white,
              elevation: 0,
              toolbarHeight: height * 0.15,
              actions: const [
                UnitSwitch(),
              ],
              bottom: const PreferredSize(
                  preferredSize: Size(double.maxFinite, 2), child: Divider()),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(flex: 8, child: TemperatureSection(city: city)),
                  Expanded(flex: 8, child: PropertiesSection(city: city)),
                  Expanded(flex: 3, child: HourlySection(cityName: city.name)),
                ],
              ),
            )),
        Positioned(
          top: -300,
          child: Container(
            height: width,
            width: width,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 80,
                  spreadRadius: 60,
                  color: Color.fromARGB(217, 239, 95, 17)),
            ], shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}
