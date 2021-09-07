import 'package:bloc_weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/presentation/components/platform_specific_spinner.dart';
import 'package:bloc_weather/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(
            "This Week",
            style: kSubTitleStyle,
          ),
          BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
            if (state is WeatherLoading) return PlatformSpecificSpinner();
            if (state is WeatherLoaded)
              return ListView.builder(
                  itemCount: state.dailyWeather.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text("Wed"),
                        Text("24"),
                        Text("18"),
                        Image.asset("images/01d@4x.png"),
                        Text("Rainy")
                      ],
                    );
                  });
            return Text("Error");
          })
        ],
      )),
    );
  }
}
