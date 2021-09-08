import 'package:bloc_weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/data/models/weather.dart';
import 'package:bloc_weather/presentation/components/hourly_forecast_block.dart';
import 'package:bloc_weather/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:bloc_weather/cubit/location_cubit.dart';
import 'package:bloc_weather/presentation/components/current_weather_tile.dart';
import 'package:bloc_weather/utils/constants.dart';

class WeatherScreen extends StatelessWidget {
  final Weather currentWeather;
  const WeatherScreen({
    Key? key,
    required this.currentWeather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
              if (state is LocationLoaded)
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${state.placemark.locality}",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<WeatherCubit>(context)
                              .getWeatherForLocation(state.location);
                        },
                        icon: Icon(
                          Icons.gps_fixed,
                        ))
                  ],
                );
              return Text(
                "Loading",
              );
            }),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat("EEEEE, h a").format(currentWeather.time),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CurrentWeatherTile(
            currentWeather: currentWeather,
          ),
          SizedBox(
            height: 80,
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Today",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Pressure",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${currentWeather.pressure.toString()} hPa",
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Visibilty",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${Utils.doubleToStringForDisplay(currentWeather.visibilty)} km",
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Humidity",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${currentWeather.humidity}%',
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    HourlyForecastBlock(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
