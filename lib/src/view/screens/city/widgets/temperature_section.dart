import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

import '../../../../core/pallet/pallet.dart';
import '../../../../data/models/today_weather_model.dart';
import '../../../../util/weather_icon_getter.dart';
import 'properties_section.dart';

class TemperatureSection extends StatefulWidget {
  const TemperatureSection({super.key, required this.city});

  final TodayWeather city;

  @override
  State<TemperatureSection> createState() => _TemperatureSectionState();
}

class _TemperatureSectionState extends State<TemperatureSection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);

    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 10.0, end: 0.0),
            from: Duration.zero,
            to: const Duration(milliseconds: 1000),
            curve: Curves.ease,
            tag: "temp-num-left")
        .addAnimatable(
            animatable: Tween<double>(begin: 0.0, end: 10.0),
            from: Duration.zero,
            to: const Duration(milliseconds: 1000),
            curve: Curves.ease,
            tag: "temp-num-right")
        .animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          KeyText(widget.city.name),
          const SizedBox(height: 12),
          IntrinsicHeight(
            child: Row(
              children: [
                AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: sequenceAnimation["temp-num-left"].value),
                          Text(
                            widget.city.main.temp.round().toString(),
                            style: const TextStyle(
                              fontSize: 150,
                              fontWeight: FontWeight.w500,
                              height: 1,
                            ),
                          ),
                          SizedBox(
                              width: sequenceAnimation["temp-num-right"].value),
                          Image.asset(
                            getWeatherIcon(widget.city.weather.first.icon),
                            width: 24,
                          ),
                        ],
                      );
                    }),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KeyText(widget.city.weather.first.main),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: RichText(
                        text: TextSpan(
                          text: "feels like ",
                          children: [
                            TextSpan(
                              text: "${widget.city.main.feelsLike}°",
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
