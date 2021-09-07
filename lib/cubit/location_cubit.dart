import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';

import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial()) {
    getLocation();
  }

  void getLocation() async {
    emit(LocationLoading());
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled)
      return emit(LocationError("Location service disabled"));
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return emit(LocationError('Location permissions are denied'));
      }
    }
    try {
      Position location = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
          location.latitude, location.longitude,
          localeIdentifier: "en_US");
      emit(LocationLoaded(location, placemarks[0]));
    } catch (err) {
      emit(LocationError("Something went wrong when acquiring location"));
    }
  }
}
