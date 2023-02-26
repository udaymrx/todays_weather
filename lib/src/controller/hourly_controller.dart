import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/hourly_temp_entity.dart';
import 'weather_controller.dart';

final hourlyWeatherProvider = AsyncNotifierProviderFamily<HourlyNotifier,
    List<HourlyTemperature>, String>(HourlyNotifier.new);

class HourlyNotifier
    extends FamilyAsyncNotifier<List<HourlyTemperature>, String> {
  Future<List<HourlyTemperature>> _fetchhourlyWeather(String cityName) async {
    final res = await ref.read(weatherRepoProvider).getHourlyWeather(cityName);
    return res.fold((l) {
      debugPrint(l.toString());
      return [];
    }, (r) {
      return hourlyTemperatureFromModel(r.list);
    });
  }

  @override
  FutureOr<List<HourlyTemperature>> build(String arg) async {
    return _fetchhourlyWeather(arg);
  }
}
