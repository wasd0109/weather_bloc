part of 'locationautocomplete_cubit.dart';

abstract class LocationAutocompleteState extends Equatable {
  const LocationAutocompleteState();

  @override
  List<Object> get props => [];
}

class LocationAutocompleteInitial extends LocationAutocompleteState {}

class LocationAutocompleteLoading extends LocationAutocompleteState {}

class LocationAutocompleteLoaded extends LocationAutocompleteState {
  final List<AutocompleteSuggestion> suggestions;
  LocationAutocompleteLoaded({
    required this.suggestions,
  });
  @override
  List<Object> get props => [suggestions];
}

class LocationAutocompleteError extends LocationAutocompleteState {
  LocationAutocompleteError(this.errorMsg);
  final String errorMsg;
  List<Object> get props => [errorMsg];
}
