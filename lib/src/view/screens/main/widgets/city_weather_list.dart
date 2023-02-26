import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../controller/weather_controller.dart';
import 'city_weather_tile.dart';

class CityWeatherList extends ConsumerWidget {
  const CityWeatherList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(weatherListProvider);
    return res.when(
      data: (cities) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return CityWeatherTile(
              city: cities[index],
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: cities.length,
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
