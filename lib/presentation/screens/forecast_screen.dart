import 'package:bloc_weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/presentation/components/platform_specific_spinner.dart';
import 'package:bloc_weather/utils/constants.dart';
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
    return Scaffold(
      body: SafeArea(child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) return PlatformSpecificSpinner();
          if (state is WeatherLoaded)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "This Week",
                  style: kSubTitleStyle,
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
                                style: TextStyle(
                                  color: kSecondaryTextColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${state.dailyWeather[i].maxTemp.toStringAsFixed(1)}°",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${state.dailyWeather[i].temp.toStringAsFixed(1)}°",
                                    style: TextStyle(
                                        color: kSecondaryTextColor,
                                        fontSize: 16),
                                  ),
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
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: Image.asset(
                                      "images/${state.dailyWeather[i].icon}@4x.png",
                                      width: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(state.dailyWeather[i].condition),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          return Text("Error");
        },
      )),
    );
  }
}
