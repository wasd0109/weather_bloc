import 'package:bloc_weather/data/models/weather.dart';
import 'package:bloc_weather/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:bloc_weather/utils/utils.dart';

class CurrentWeatherTile extends StatelessWidget {
  final Weather currentWeather;
  const CurrentWeatherTile({
    Key? key,
    required this.currentWeather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          currentWeather.icon,
          style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 100),
        ),
        Text(
          "${Utils.doubleToStringForDisplay(currentWeather.temp)}°",
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          StringUtils.capitalize(currentWeather.description),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
