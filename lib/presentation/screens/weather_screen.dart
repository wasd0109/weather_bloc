import 'package:bloc_weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/data/models/weather.dart';
import 'package:bloc_weather/presentation/components/hourly_forecast_block.dart';
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
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        letterSpacing: -0.5,
                      ),
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
              style: TextStyle(color: kSecondaryTextColor, fontSize: 20),
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
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Today",
                    style: kSubTitleStyle,
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
                            style: TextStyle(
                                fontSize: 20, color: kSecondaryTextColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${currentWeather.pressure.toString()} hPa",
                            style: TextStyle(fontSize: 25),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Visibilty",
                            style: TextStyle(
                                fontSize: 20, color: kSecondaryTextColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${currentWeather.visibilty.toString()} km",
                            style: TextStyle(fontSize: 25),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Humidity",
                            style: TextStyle(
                                fontSize: 20, color: kSecondaryTextColor),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${currentWeather.humidity}%',
                            style: TextStyle(fontSize: 25),
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
        ],
      ),
    );
  }
}
