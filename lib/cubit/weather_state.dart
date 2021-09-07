part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final Weather currentWeather;
  final List<Weather> hourlyWeather;
  final List<WeatherForecast> dailyWeather;
  WeatherLoaded(
      {required this.currentWeather,
      required this.hourlyWeather,
      required this.dailyWeather});

  @override
  List<Object> get props => [currentWeather, hourlyWeather];
}

class WeatherError extends WeatherState {
  WeatherError(this.errorMsg);
  final String errorMsg;
  List<Object> get props => [errorMsg];
}
