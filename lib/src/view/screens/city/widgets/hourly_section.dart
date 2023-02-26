import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controller/hourly_controller.dart';
import '../../../../core/pallet/pallet.dart';
import '../../../../domain/entities/hourly_temp_entity.dart';
import '../../../../util/time_formatter.dart';
import 'properties_section.dart';

class HourlySection extends ConsumerWidget {
  const HourlySection({super.key, required this.cityName});

  final String cityName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(hourlyWeatherProvider(cityName));
    return res.when(
      data: (temperatures) {
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              HourlyItem(temp: temperatures[index]),
          separatorBuilder: (context, index) => const SizedBox(width: 40),
          itemCount: temperatures.length,
        );
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
