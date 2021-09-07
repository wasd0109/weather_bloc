import 'package:bloc_weather/data/models/weather.dart';
import 'package:flutter/material.dart';

class WeatherForecast extends Weather {
  // temp from Weather used as minTemp
  double maxTemp;

  WeatherForecast({
    required this.maxTemp,
    required condition,
    required description,
    required pressure,
    required humidity,
    required icon,
    required temp,
    required time,
  }) : super(
            condition: condition,
            description: description,
            icon: icon,
            temp: temp,
            time: time,
            humidity: humidity,
            pressure: pressure);

  static WeatherForecast fromJSON(Map<String, dynamic> data) {
    final String condition = data["weather"][0]["main"];
    final String description = data["weather"][0]["description"];
    final double temp = data["temp"]["min"].toDouble();
    final DateTime time =
        DateTime.fromMillisecondsSinceEpoch(data["dt"] * 1000);
    final String icon = data["weather"][0]["icon"];
    final int pressure = data["pressure"];

    final int humidity = data["humidity"];
    final double maxTemp = data["temp"]["max"].toDouble();

    return WeatherForecast(
      maxTemp: maxTemp,
      condition: condition,
      description: description,
      humidity: humidity,
      icon: icon,
      pressure: pressure,
      temp: temp,
      time: time,
    );
  }
}
