import 'package:basic_utils/basic_utils.dart';
import 'package:bloc_weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/presentation/components/platform_specific_spinner.dart';
import 'package:bloc_weather/utils/utils.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HourlyForecastBlock extends StatelessWidget {
  const HourlyForecastBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoaded)
            return ListView.builder(
              itemCount: state.hourlyWeather.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    Text(
                      DateFormat("h a").format(state.hourlyWeather[i].time) ==
                                  "12 AM" ||
                              i == 0
                          ? DateFormat("MM/dd")
                              .format(state.hourlyWeather[i].time)
                          : "",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateFormat("h a").format(state.hourlyWeather[i].time),
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      height: 60,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Image.asset(
                          "images/${state.hourlyWeather[i].icon}@4x.png",
                        ),
                      ),
                    ),
                    Text(
                      "${Utils.doubleToStringForDisplay(state.hourlyWeather[i].temp)}°",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${StringUtils.capitalize(state.hourlyWeather[i].condition)}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(CommunityMaterialIcons.water_percent),
                        Text(
                          "${state.hourlyWeather[i].humidity}%",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          return PlatformSpecificSpinner();
        },
      ),
    );
  }
}
