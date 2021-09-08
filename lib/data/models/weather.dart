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
    final String icon = Weather.iconToData(data["weather"][0]["icon"]);
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

  static String iconToData(String icon) {
    final iconEnum = OpenWeatherMapIcon.values.firstWhere((e) {
      print(e);
      print("icon$icon");
      return e.toString() == "OpenWeatherMapIcon.icon$icon";
    });
    switch (iconEnum) {
      case OpenWeatherMapIcon.icon01d:
      case OpenWeatherMapIcon.icon01n:
        return "☀️";
      case OpenWeatherMapIcon.icon02d:
      case OpenWeatherMapIcon.icon02n:
        return "🌤️";
      case OpenWeatherMapIcon.icon03d:
      case OpenWeatherMapIcon.icon03n:
        return "⛅";
      case OpenWeatherMapIcon.icon04d:
      case OpenWeatherMapIcon.icon04n:
        return "☁️";
      case OpenWeatherMapIcon.icon09d:
      case OpenWeatherMapIcon.icon09n:
        return "🌦️";
      case OpenWeatherMapIcon.icon10d:
      case OpenWeatherMapIcon.icon10n:
        return "🌧️";
      case OpenWeatherMapIcon.icon11d:
      case OpenWeatherMapIcon.icon11n:
        return "⛈️";
      case OpenWeatherMapIcon.icon13d:

      case OpenWeatherMapIcon.icon13n:
        return "❄️";
      case OpenWeatherMapIcon.icon50d:

      case OpenWeatherMapIcon.icon50n:
        return "🌫️";
      default:
        throw ("No corresponding code");
    }
  }
}

enum OpenWeatherMapIcon {
  icon01d,
  icon01n,
  icon02d,
  icon02n,
  icon03d,
  icon03n,
  icon04d,
  icon04n,
  icon09d,
  icon09n,
  icon10d,
  icon10n,
  icon11d,
  icon11n,
  icon13d,
  icon13n,
  icon50d,
  icon50n
}
