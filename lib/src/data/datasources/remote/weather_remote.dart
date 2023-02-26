import 'package:dartz/dartz.dart';
import 'package:today_weather/api_key.dart';

import '../../../core/typedefs.dart';
import '../../models/forecast_model.dart';
import '../../models/today_weather_model.dart';
import 'api/api_provider.dart';

abstract class WeatherRemoteDatasource {
  FutureEither<TodayWeather> getSingleWeather(String cityName);
  FutureEither<Forecast> getHourlyWeather(String cityName);
}

class WeatherRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final ApiProvider apiProvider;

  WeatherRemoteDatasourceImpl(this.apiProvider);

  @override
  FutureEither<TodayWeather> getSingleWeather(String cityName) async {
    final res = await apiProvider.get(
      '/weather',
      query: {
        "q": cityName,
        "units": "metric",
        "appid": apiKey,
      },
    );
    return res.fold((l) {
      return left(l);
    }, (r) {
      final char = TodayWeather.fromJson(r);
      return right(char);
    });
  }

  @override
  FutureEither<Forecast> getHourlyWeather(String cityName) async {
    final res = await apiProvider.get(
      '/forecast',
      query: {
        "q": cityName,
        "units": "metric",
        "cnt": "8",
        "appid": apiKey,
      },
    );
    return res.fold((l) {
      return left(l);
    }, (r) {
      final char = Forecast.fromJson(r);
      return right(char);
    });
  }
}
