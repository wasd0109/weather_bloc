import 'package:bloc/bloc.dart';
import 'package:bloc_weather/data/api/location_autocomplete_repository.dart';
import 'package:bloc_weather/data/models/autocomplete_suggestion.dart';
import 'package:equatable/equatable.dart';

part 'locationautocomplete_state.dart';

class LocationAutocompleteCubit extends Cubit<LocationAutocompleteState> {
  LocationAutocompleteCubit() : super(LocationAutocompleteInitial());

  LocationAutocompeleteRepository _repository =
      LocationAutocompeleteRepository();

  void getSuggestions(String input) async {
    emit(LocationAutocompleteLoading());
    final suggestions = await _repository.getSuggestion(input);
    emit(LocationAutocompleteLoaded(suggestions: suggestions));
  }

  void resetSuggestion() {
    emit(LocationAutocompleteInitial());
  }
}
