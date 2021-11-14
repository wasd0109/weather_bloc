import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LocationAutocompleteApi {
  final String apiKey = dotenv.env["GOOGLE_MAP_API_KEY"] as String;
  Future<http.Response> getSuggestion(String input) async {
    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=(regions)&key=$apiKey";
    return http.get(Uri.parse(url));
  }
}
