import 'package:flutter/material.dart';
import 'package:sample_weather/models/weather_model.dart';
import 'package:sample_weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService("e2c6869b8ecd42b68a173646232710");
  Weather? _weather;

  _fetchWeather() async {
    var location = await _weatherService.getCurrentCity();
    try {
      final weather =
          await _weatherService.getWeather(location.lat, location.lon);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getPathIconWeather() {
    if (_weather?.iconCondition != null) {
      return "https:${_weather?.iconCondition}";
    } else {
      return "https://cdn.weatherapi.com/weather/64x64/day/116.png";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(_weather?.cityName ?? "Loading city..."),
              FadeInImage.assetNetwork(
                placeholder: "assets/loading.gif",
                image: getPathIconWeather(),
                width: 24,
                height: 24,
              ),
            ]),
            Text('${_weather?.temperature.round()}℃'),
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}
