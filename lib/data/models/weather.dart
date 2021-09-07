import 'dart:convert';

class Weather {
  String condition;
  String description;
  double temp;
  DateTime time;
  String icon;
  int pressure;
  int humidity;
  double? visibilty;

  Weather(
      {required this.condition,
      required this.description,
      required this.temp,
      required this.time,
      required this.icon,
      required this.pressure,
      required this.humidity,
      this.visibilty});

  static Weather fromJSON(Map<String, dynamic> data) {
    final String condition = data["weather"][0]["main"];
    final String description = data["weather"][0]["description"];
    final double temp = data["temp"].toDouble();
    final DateTime time =
        DateTime.fromMillisecondsSinceEpoch(data["dt"] * 1000);
    final String icon = data["weather"][0]["icon"];
    final int pressure = data["pressure"];
    final int humidity = data["humidity"];
    final double visibilty = data["visibility"] / 1000;
    return Weather(
        condition: condition,
        description: description,
        temp: temp,
        time: time,
        icon: icon,
        pressure: pressure,
        humidity: humidity,
        visibilty: visibilty);
  }
}
