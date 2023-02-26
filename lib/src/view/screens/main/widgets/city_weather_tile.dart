import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_weather/src/core/pallet/pallet.dart';
import 'package:today_weather/src/data/models/today_weather_model.dart';
import 'package:today_weather/src/util/country_code.dart';
import 'package:today_weather/src/util/time_formatter.dart';
import 'package:today_weather/src/util/weather_icon_getter.dart';

import '../../city/city_page.dart';

class CityWeatherTile extends StatelessWidget {
  const CityWeatherTile({super.key, required this.city});

  final TodayWeather city;

  TextStyle smallTextStyle() {
    return const TextStyle(
      fontSize: 14,
      color: Pallet.darkGrey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => CityPage(city: city),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(children: [
          Row(
            children: [
              Consumer(builder: (context, ref, child) {
                final country = ref.read(countryProvider(city.sys.country));
                return Text(
                  country,
                  style: smallTextStyle(),
                );
              }),
              const Spacer(),
              Text(
                toAmPm(fromTimeZone(city.timezone)),
                style: smallTextStyle(),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                city.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Pallet.black,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    "${city.main.temp}°",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Pallet.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    getWeatherIcon(city.weather.first.icon),
                    width: 18,
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
