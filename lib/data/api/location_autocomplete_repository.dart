import 'dart:convert';

import 'package:bloc_weather/data/api/location_autocomplete_api.dart';
import 'package:bloc_weather/data/models/autocomplete_suggestion.dart';
import 'package:http/http.dart' as http;

class LocationAutocompeleteRepository {
  final LocationAutocompleteApi _locationAutocompleteApi =
      LocationAutocompleteApi();

  Future<List<AutocompleteSuggestion>> getSuggestion(String input) async {
    final http.Response rawRes =
        await _locationAutocompleteApi.getSuggestion(input);
    final Map data = jsonDecode(rawRes.body);
    final List predictions = data["predictions"];
    final List<AutocompleteSuggestion> results = [];
    for (dynamic prediction in predictions) {
      results.add(AutocompleteSuggestion.fromJSON(prediction));
    }
    return results;
  }
}
