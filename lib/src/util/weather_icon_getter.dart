import 'package:today_weather/src/core/constants/assets.dart';

/// returns a Icon path of asset from the given icon name
String getWeatherIcon(String icon) {
  switch (icon) {
    case "01n":
      return Assets.sunny;
    case "02n":
      return Assets.partlyCloud;
    case "03n":
      return Assets.cloudy;
    case "04n":
      return Assets.brokenCloud;
    case "09n":
      return Assets.rain;
    case "10n":
      return Assets.rain;
    case "11n":
      return Assets.rain;
    case "13n":
      return Assets.rain;
    case "50n":
      return Assets.brokenCloud;

    default:
      return Assets.brokenCloud;
  }
}
