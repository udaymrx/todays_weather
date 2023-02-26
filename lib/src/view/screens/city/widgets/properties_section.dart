import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

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

class PropertiesSection extends StatefulWidget {
  const PropertiesSection({super.key, required this.city});

  final TodayWeather city;

  @override
  State<PropertiesSection> createState() => _PropertiesSectionState();
}

class _PropertiesSectionState extends State<PropertiesSection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);

    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 30.0, end: 0.0),
            from: Duration.zero,
            to: const Duration(milliseconds: 1000),
            curve: Curves.ease,
            tag: "shift-left")
        .animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TextStyle _valueTextStyle() {
    return const TextStyle(
      fontSize: 15,
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
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: sequenceAnimation["shift-left"].value,
                              ),
                              const Icon(Icons.arrow_upward),
                              Text(
                                "${widget.city.main.tempMax}°",
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
                                    "${widget.city.main.humidity}%",
                                    style: _valueTextStyle(),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "${widget.city.visibility} m",
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
                              SizedBox(
                                width: sequenceAnimation["shift-left"].value,
                              ),
                              const Icon(Icons.arrow_downward),
                              Text(
                                "${widget.city.main.tempMin}°",
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
                                    "${widget.city.wind.speed} m/s",
                                    style: _valueTextStyle(),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "${widget.city.main.pressure} mmHg",
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
                );
              }),
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
