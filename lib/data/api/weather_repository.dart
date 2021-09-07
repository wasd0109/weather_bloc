import 'dart:convert';

import 'package:bloc_weather/data/api/weather_api.dart';
import 'package:bloc_weather/data/models/weather.dart';
import 'package:bloc_weather/data/models/weather_forecast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherRespository {
  final WeatherApi weatherApi = WeatherApi();

  Future<Map<String, dynamic>> getWeatherForLocation(Position location) async {
    final http.Response rawRes =
        await weatherApi.getRawWeatherForLocation(location);
    final Map data = jsonDecode(rawRes.body);
    final Weather currentWeather = Weather.fromJSON(data["current"]);
    final List hourlyData = data["hourly"];
    final List<Weather> hourlyWeather = [];
    for (var forecast in hourlyData) {
      final Weather hourlyForecast = Weather.fromJSON(forecast);
      hourlyWeather.add(hourlyForecast);
    }
    final List dailyData = data["daily"];
    final List<WeatherForecast> dailyWeather = [];
    for (var forecast in dailyData) {
      final WeatherForecast dailyForecast = WeatherForecast.fromJSON(forecast);
      dailyWeather.add(dailyForecast);
    }
    return {
      "current": currentWeather,
      "hourly": hourlyWeather,
      "daily": dailyWeather
    };
  }
}
