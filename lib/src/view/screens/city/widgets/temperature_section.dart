import 'package:flutter/material.dart';

import '../../../../core/pallet/pallet.dart';
import '../../../../data/models/today_weather_model.dart';
import '../../../../util/weather_icon_getter.dart';
import 'properties_section.dart';

class TemperatureSection extends StatelessWidget {
  const TemperatureSection({super.key, required this.city});

  final TodayWeather city;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          KeyText(city.name),
          const SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city.main.temp.round().toString(),
                      style: const TextStyle(
                        fontSize: 150,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      getWeatherIcon(city.weather.first.icon),
                      width: 24,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KeyText(city.weather.first.main),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: RichText(
                        text: TextSpan(
                          text: "feels like ",
                          children: [
                            TextSpan(
                              text: "${city.main.feelsLike}°",
                              style: const TextStyle(
                                color: Pallet.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Geometria",
                            color: Pallet.darkGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
