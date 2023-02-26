// To parse this JSON data, do
//
//     final forecast = forecastFromJson(jsonString);

import 'dart:convert';

Forecast forecastFromJson(String str) => Forecast.fromJson(json.decode(str));

String forecastToJson(Forecast data) => json.encode(data.toJson());

class Forecast {
  Forecast({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  final String cod;
  final dynamic message;
  final int cnt;
  final List<Temperature> list;
  final City city;

  Forecast copyWith({
    String? cod,
    dynamic message,
    int? cnt,
    List<Temperature>? list,
    City? city,
  }) =>
      Forecast(
        cod: cod ?? this.cod,
        message: message ?? this.message,
        cnt: cnt ?? this.cnt,
        list: list ?? this.list,
        city: city ?? this.city,
      );

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<Temperature>.from(
            json["list"].map((x) => Temperature.fromJson(x))),
        city: City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<Temperature>.from(list.map((x) => x.toJson())),
        "city": city.toJson(),
      };
}

class City {
  City({
    required this.id,
    required this.name,
    required this.country,
    required this.population,
    required this.timezone,
  });

  final int id;
  final String name;
  final String country;
  final int population;
  final int timezone;

  City copyWith({
    int? id,
    String? name,
    String? country,
    int? population,
    int? timezone,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        country: country ?? this.country,
        population: population ?? this.population,
        timezone: timezone ?? this.timezone,
      );

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "population": population,
        "timezone": timezone,
      };
}

class Temperature {
  Temperature({
    required this.main,
    required this.weather,
    required this.wind,
    required this.visibility,
    required this.dtTxt,
  });

  final Main main;
  final List<Weather> weather;
  final Wind wind;
  final int visibility;
  final DateTime dtTxt;

  Temperature copyWith({
    Main? main,
    List<Weather>? weather,
    Wind? wind,
    int? visibility,
    DateTime? dtTxt,
  }) =>
      Temperature(
        main: main ?? this.main,
        weather: weather ?? this.weather,
        wind: wind ?? this.wind,
        visibility: visibility ?? this.visibility,
        dtTxt: dtTxt ?? this.dtTxt,
      );

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
        main: Main.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        dtTxt: DateTime.parse(json["dt_txt"]),
      );

  Map<String, dynamic> toJson() => {
        "main": main.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "wind": wind.toJson(),
        "visibility": visibility,
        "dt_txt": dtTxt.toIso8601String(),
      };
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;

  Main copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? seaLevel,
    int? grndLevel,
    int? humidity,
    double? tempKf,
  }) =>
      Main(
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        pressure: pressure ?? this.pressure,
        seaLevel: seaLevel ?? this.seaLevel,
        grndLevel: grndLevel ?? this.grndLevel,
        humidity: humidity ?? this.humidity,
        tempKf: tempKf ?? this.tempKf,
      );

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int id;
  final String main;
  final String description;
  final String icon;

  Weather copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      Weather(
        id: id ?? this.id,
        main: main ?? this.main,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  final double speed;
  final int deg;
  final double gust;

  Wind copyWith({
    double? speed,
    int? deg,
    double? gust,
  }) =>
      Wind(
        speed: speed ?? this.speed,
        deg: deg ?? this.deg,
        gust: gust ?? this.gust,
      );

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
        gust: json["gust"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };
}
