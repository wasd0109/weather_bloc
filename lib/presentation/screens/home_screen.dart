import 'package:bloc_weather/cubit/location_cubit.dart';
import 'package:bloc_weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/presentation/components/current_weather_tile.dart';
import 'package:bloc_weather/presentation/components/platform_specific_spinner.dart';
import 'package:bloc_weather/presentation/screens/forecast_screen.dart';
import 'package:bloc_weather/presentation/screens/search_screen.dart';
import 'package:bloc_weather/presentation/screens/weather_screen.dart';
import 'package:bloc_weather/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  PageController _controller = PageController(initialPage: 1);
  bool showScreenHint = true;
  late AnimationController _animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationCubit>(context).getLocation();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );
    animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInExpo);
    _animationController.forward();
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        setState(() {
          showScreenHint = false;
        });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          width: double.infinity,
          child: MultiBlocListener(
            listeners: [
              BlocListener<LocationCubit, LocationState>(
                listener: (context, state) {
                  if (state is LocationLoaded) {
                    BlocProvider.of<WeatherCubit>(context)
                        .getWeatherForLocation(state.location);
                  }
                },
              ),
            ],
            child: BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading || state is WeatherInitial)
                  return Center(
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      child: PlatformSpecificSpinner(),
                    ),
                  );
                if (state is WeatherLoaded)
                  return Column(
                    children: [
                      Visibility(
                        visible: showScreenHint,
                        child: Opacity(
                          opacity: 1.0 - animation.value,
                          child: Column(
                            children: [
                              Icon(
                                Icons.expand_less,
                                color: kSecondaryTextColor,
                              ),
                              Text(
                                "Search",
                                style: TextStyle(color: kSecondaryTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: PageView(
                          onPageChanged: (index) {
                            if (index == 1)
                              WidgetsBinding.instance?.focusManager.primaryFocus
                                  ?.unfocus();
                          },
                          scrollDirection: Axis.vertical,
                          controller: _controller,
                          children: [
                            SearchScreen(),
                            WeatherScreen(
                              currentWeather: state.currentWeather,
                            ),
                            ForecastScreen(),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: showScreenHint,
                        child: Opacity(
                          opacity: 1.0 - animation.value,
                          child: Column(
                            children: [
                              Icon(
                                Icons.expand_more,
                                color: kSecondaryTextColor,
                              ),
                              Text(
                                "Forecast",
                                style: TextStyle(color: kSecondaryTextColor),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                if (state is WeatherError)
                  return Text(state.errorMsg);
                else
                  return Text("Something went wrong");
              },
            ),
          ),
        ),
      ),
    );
  }
}
