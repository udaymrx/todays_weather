import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

import '../../../../controller/hourly_controller.dart';
import '../../../../core/pallet/pallet.dart';
import '../../../../domain/entities/hourly_temp_entity.dart';
import '../../../../util/time_formatter.dart';
import 'properties_section.dart';

class HourlySection extends ConsumerStatefulWidget {
  const HourlySection({super.key, required this.cityName});

  final String cityName;

  @override
  ConsumerState<HourlySection> createState() => _HourlySectionState();
}

class _HourlySectionState extends ConsumerState<HourlySection>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late SequenceAnimation sequenceAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);

    sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 160.0, end: 0.0),
            from: Duration.zero,
            to: const Duration(milliseconds: 1000),
            curve: Curves.ease,
            tag: "shift-list-left")
        .animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(hourlyWeatherProvider(widget.cityName));
    return res.when(
      data: (temperatures) {
        controller.forward();

        return AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Padding(
                padding: EdgeInsets.only(
                    left: sequenceAnimation["shift-list-left"].value),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      HourlyItem(temp: temperatures[index]),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 40),
                  itemCount: temperatures.length,
                ),
              );
            });
      },
      error: (error, stackTrace) {
        debugPrint(error.toString());
        debugPrint(stackTrace.toString());
        return const SizedBox();
      },
      loading: () => const SizedBox(),
    );
  }
}

class HourlyItem extends StatelessWidget {
  const HourlyItem({super.key, required this.temp});

  final HourlyTemperature temp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KeyText(toAmPm(temp.time)),
        const SizedBox(height: 10),
        Text(
          "${temp.temperature}°",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Pallet.black,
          ),
        ),
      ],
    );
  }
}
