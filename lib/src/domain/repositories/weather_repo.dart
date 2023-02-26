
import '../../core/typedefs.dart';
import '../../data/models/forecast_model.dart';
import '../../data/models/today_weather_model.dart';

abstract class WeatherRepo {
  FutureEither<TodayWeather> getSingleWeather(String cityName);
  FutureEither<Forecast> getHourlyWeather(String cityName);
}
