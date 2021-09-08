import 'dart:ui';

import 'package:bloc_weather/cubit/weather_cubit.dart';
import 'package:bloc_weather/presentation/screens/home_screen.dart';
import 'package:bloc_weather/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cubit/location_cubit.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
        darkTheme: CustomTheme.getDarkTheme(
          context,
        ),
      ),
    );
  }
}
// textTheme: GoogleFonts.latoTextTheme(
//             Theme.of(context).textTheme,
//           ).copyWith(
//             bodyText2: TextStyle(color: Colors.white),
//             bodyText1: TextStyle(color: Colors.white70),
//             headline1: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 30,
//                 letterSpacing: -0.5,
//                 color: Colors.white),
//             headline2: TextStyle(
//               fontSize: 25,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//           iconTheme: IconThemeData(color: Colors.white),
//           primaryColor: Colors.grey[900],
//           cardColor: Color(0xFF303030),
//           cardTheme: CardTheme(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30),
//             ),
//           ),