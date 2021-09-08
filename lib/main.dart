import 'dart:ui';

import 'package:bloc_weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/presentation/screens/home_screen.dart';
import 'package:bloc_weather/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cubit/location_cubit.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  var brightness = SchedulerBinding.instance!.window.platformBrightness;
  bool isDarkMode = brightness == Brightness.dark;
  isDarkMode
      ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light)
      : SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
        BlocProvider(
          create: (context) => WeatherCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: HomeScreen(),
        theme: CustomTheme.getLightTheme(context),
        darkTheme: CustomTheme.getDarkTheme(context),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
