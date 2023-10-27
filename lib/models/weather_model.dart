class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String iconCondition;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition,
      required this.iconCondition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['location']['name'],
        temperature: json['current']['temp_c'].toDouble(),
        mainCondition: json['current']['condition']['text'],
        iconCondition: json['current']['condition']['icon'],
    );
  }
}

class Condition {}
