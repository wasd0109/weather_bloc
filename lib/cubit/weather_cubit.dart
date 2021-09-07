import 'package:bloc/bloc.dart';
import 'package:bloc_weather/data/api/weather_repository.dart';
import 'package:bloc_weather/data/models/weather.dart';
import 'package:bloc_weather/data/models/weather_forecast.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  WeatherRespository weatherRespository = WeatherRespository();

  void getWeatherForLocation(Position location) async {
    emit(WeatherLoading());
    try {
      final result = await weatherRespository.getWeatherForLocation(location);

      emit(WeatherLoaded(
        currentWeather: result["current"],
        hourlyWeather: result["hourly"],
        dailyWeather: result["daily"],
      ));
    } catch (err) {
      emit(WeatherError(err.toString()));
    }
  }
}
