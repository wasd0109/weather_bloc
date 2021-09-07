import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  static const String apiKey = "1fcdeb7cf1c864b04132bc98c494acc6";
  Future<http.Response> getRawWeatherForLocation(Position location) {
    final url =
        "https://api.openweathermap.org/data/2.5/onecall?units=metric&lat=${location.latitude.toString()}&lon=${location.longitude.toString()}&appid=$apiKey";
    return http.get(Uri.parse(url));
  }
}
