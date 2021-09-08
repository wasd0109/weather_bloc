import 'package:bloc_weather/cubit/location_cubit.dart';
import 'package:bloc_weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/presentation/components/platform_specific_spinner.dart';
import 'package:bloc_weather/presentation/screens/forecast_screen.dart';
import 'package:bloc_weather/presentation/screens/search_screen.dart';
import 'package:bloc_weather/presentation/screens/weather_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          MultiBlocListener(
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
                  return Stack(
                    children: [
                      Positioned(
                        right: 8.0,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: 3,
                            axisDirection: Axis.vertical,
                            effect: ExpandingDotsEffect(
                              dotColor: Colors.grey.shade400,
                              activeDotColor: Theme.of(context).accentColor,
                              dotHeight: 10.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: SafeArea(
                          child: PageView(
                            onPageChanged: (index) {
                              if (index == 1)
                                WidgetsBinding
                                    .instance?.focusManager.primaryFocus
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
                      ),
                    ],
                  );
                if (state is WeatherError)
                  return Center(child: Text(state.errorMsg));
                else
                  return Text("Something went wrong");
              },
            ),
          ),
        ],
      ),
    );
  }
}
