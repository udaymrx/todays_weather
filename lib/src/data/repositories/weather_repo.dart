import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/typedefs.dart';
import '../../domain/repositories/weather_repo.dart';
import '../datasources/remote/api/api_provider.dart';
import '../datasources/remote/weather_remote.dart';
import '../models/forecast_model.dart';
import '../models/today_weather_model.dart';

final weatherRemoteProvider = Provider<WeatherRemoteDatasource>((ref) {
  return WeatherRemoteDatasourceImpl(ref.read(apiProvider));
});

class WeatherRepoImpl implements WeatherRepo {
  final WeatherRemoteDatasource weatherRemoteDatasource;

  WeatherRepoImpl(this.weatherRemoteDatasource);

  @override
  FutureEither<Forecast> getHourlyWeather(String cityName) {
    return weatherRemoteDatasource.getHourlyWeather(cityName);
  }

  @override
  FutureEither<TodayWeather> getSingleWeather(String cityName) {
    return weatherRemoteDatasource.getSingleWeather(cityName);
  }
}
