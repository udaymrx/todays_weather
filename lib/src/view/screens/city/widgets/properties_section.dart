import 'package:flutter/material.dart';

import '../../../../core/pallet/pallet.dart';
import '../../../../data/models/today_weather_model.dart';

class KeyText extends Text {
  const KeyText(super.data, {super.key})
      : super(
          style: const TextStyle(
            fontSize: 15,
            color: Pallet.darkGrey,
          ),
        );
}

class PropertiesSection extends StatelessWidget {
  const PropertiesSection({super.key, required this.city});

  final TodayWeather city;

  TextStyle _valueTextStyle() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Pallet.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward),
                        Text(
                          "${city.main.tempMax}°",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            KeyText("humidity"),
                            SizedBox(height: 20),
                            KeyText("visibility"),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${city.main.humidity}%",
                              style: _valueTextStyle(),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "${city.visibility} m",
                              style: _valueTextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.arrow_downward),
                        Text(
                          "${city.main.tempMin}°",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            KeyText("wind"),
                            SizedBox(height: 20),
                            KeyText("pressure"),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${city.wind.speed} m/s",
                              style: _valueTextStyle(),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "${city.main.pressure} mmHg",
                              style: _valueTextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
