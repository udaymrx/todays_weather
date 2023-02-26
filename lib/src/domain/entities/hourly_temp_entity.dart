// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../data/models/forecast_model.dart';

List<HourlyTemperature> hourlyTemperatureFromModel(List<Temperature> list) =>
    List<HourlyTemperature>.from(
        list.map((x) => HourlyTemperature.fromModel(x)));

class HourlyTemperature {
  final DateTime time;
  final double temperature;
  HourlyTemperature({
    required this.time,
    required this.temperature,
  });

  HourlyTemperature copyWith({
    DateTime? time,
    double? temperature,
  }) {
    return HourlyTemperature(
      time: time ?? this.time,
      temperature: temperature ?? this.temperature,
    );
  }

  factory HourlyTemperature.fromJson(Map<String, dynamic> json) =>
      HourlyTemperature(
        time: DateTime.parse(json["time"]),
        temperature: json["temperature"]?.toDouble(),
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time.toIso8601String(),
      'temperature': temperature,
    };
  }

  String toJson() => json.encode(toMap());

  factory HourlyTemperature.fromModel(Temperature temperature) =>
      HourlyTemperature(
        time: temperature.dtTxt,
        temperature: temperature.main.temp,
      );

  @override
  String toString() =>
      'HourlyTemperature(time: $time, temperature: $temperature)';

  @override
  bool operator ==(covariant HourlyTemperature other) {
    if (identical(this, other)) return true;

    return other.time == time && other.temperature == temperature;
  }

  @override
  int get hashCode => time.hashCode ^ temperature.hashCode;
}
