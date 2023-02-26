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
    return Scaffold(
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
        ));
  }
}
