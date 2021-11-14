import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final String apiKey = dotenv.env["OPEN_WEATHER_MAP_API_KEY"] as String;
  Future<http.Response> getRawWeatherForLocation(Position location) {
    final url =
        "https://api.openweathermap.org/data/2.5/onecall?units=metric&lat=${location.latitude.toString()}&lon=${location.longitude.toString()}&appid=$apiKey";
    return http.get(Uri.parse(url));
  }
}
