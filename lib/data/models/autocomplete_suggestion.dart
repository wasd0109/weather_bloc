class AutocompleteSuggestion {
  final String placeId;
  final String description;
  AutocompleteSuggestion({
    required this.placeId,
    required this.description,
  });

  static AutocompleteSuggestion fromJSON(Map<String, dynamic> data) {
    final description = data["description"];
    final placeId = data["place_id"];
    return AutocompleteSuggestion(placeId: placeId, description: description);
  }
}
