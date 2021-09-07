// import 'package:bloc_weather/data/models/weather.dart';

// class HourlyForecast extends Weather {
//   double visibilty;
//   int humidity;
//   HourlyForecast({
//     required this.pressure,
//     required this.visibilty,
//     required this.humidity,
//     required condition,
//     required description,
//     required icon,
//     required temp,
//     required time,
//   }) : super(
//             condition: condition,
//             description: description,
//             icon: icon,
//             temp: temp,
//             time: time);

//   static HourlyForecast fromJSON(Map<String, dynamic> data) {
//     final String condition = data["weather"][0]["main"];
//     final String description = data["weather"][0]["description"];
//     final double temp = data["temp"].toDouble();
//     final DateTime time =
//         DateTime.fromMillisecondsSinceEpoch(data["dt"] * 1000);
//     final String icon = data["weather"][0]["icon"];
//     final int pressure = data["pressure"];

//     final int humidity = data["humidity"];
//     final double visibilty = data["visibility"] / 1000;

//     return HourlyForecast(
//         condition: condition,
//         description: description,
//         temp: temp,
//         time: time,
//         icon: icon,
//         pressure: pressure,
//         humidity: humidity,
//         visibilty: visibilty);
//   }
// }
