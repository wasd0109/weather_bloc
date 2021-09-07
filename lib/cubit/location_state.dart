part of 'location_cubit.dart';

@immutable
abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationState {
  List<Object> get props => [];
}

class LocationLoaded extends LocationState {
  LocationLoaded(this.location, this.placemark);
  final Position location;
  final Placemark placemark;
  @override
  List<Object> get props => [location, placemark];
}

class LocationError extends LocationState {
  LocationError(this.errorMsg);
  final String errorMsg;
  List<Object> get props => [errorMsg];
}
