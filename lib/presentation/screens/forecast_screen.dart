import 'package:bloc_weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/presentation/components/platform_specific_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) return PlatformSpecificSpinner();
          if (state is WeatherLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "This Week",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.dailyWeather.length,
                    itemBuilder: (context, i) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                  DateFormat.E()
                                      .format(state.dailyWeather[i].time)
                                      .toUpperCase(),
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${state.dailyWeather[i].maxTemp.toStringAsFixed(1)}°",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                      "${state.dailyWeather[i].temp.toStringAsFixed(1)}°",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    state.dailyWeather[i].icon,
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    state.dailyWeather[i].condition,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chance of Rain",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              "${state.dailyWeather[0].chanceOfRain.toString()}%",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            SizedBox(
                              width: 150,
                            ),
                            Text(
                              state.dailyWeather[0].chanceOfRain > 0
                                  ? "☂️"
                                  : "☀️",
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Do you know?",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ],
            );
          }
          return Text("Error");
        },
      ),
    );
  }
}
