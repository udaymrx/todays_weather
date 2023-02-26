import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_weather/src/data/models/today_weather_model.dart';
import 'package:today_weather/src/data/repositories/weather_repo.dart';

import '../domain/repositories/weather_repo.dart';


final weatherRepoProvider = Provider<WeatherRepo>((ref) {
  return WeatherRepoImpl(ref.read(weatherRemoteProvider));
});

final weatherListProvider =
    AsyncNotifierProvider<WeatherListNotifier, List<TodayWeather>>(
        WeatherListNotifier.new);

class WeatherListNotifier extends AsyncNotifier<List<TodayWeather>> {
  Future<List<TodayWeather>> _fetchWeathers() async {
    List<TodayWeather> weathers = [];
    List<String> cities = [
      "London",
      "Sydney",
      "Washington",
      "Miami",
      "Noida",
      "Shanghai",
    ];
    for (final city in cities) {
      final val = await _fetchWeather(city);

      if (val != null) {
        weathers.add(val);
      }
    }
    return weathers;
  }

  Future<TodayWeather?> _fetchWeather(String cityName) async {
    final res = await ref.read(weatherRepoProvider).getSingleWeather(cityName);
    return res.fold((l) {
      debugPrint(l.toString());
      return null;
    }, (r) => r);
  }

  @override
  FutureOr<List<TodayWeather>> build() {
    return _fetchWeathers();
  }
}